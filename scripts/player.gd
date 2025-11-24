extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DASH = 300
const DASH_DURATION = 0.15
const DOUBLE_TAP_TIME = 0.2
const DASH_COOLDOWN = 1.0 # 1 Second cooldown


var last_tap_time = { "left" : 0.0, "right": 0.0 }


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var dash_animation = preload("res://scenes/trail.tscn")
@onready var global = $"/root/Global"
@onready var cam = $Camera2D
@onready var hud = $Camera2D/HUD
@onready var timer = $SlowMo
var default_cam_pos
var ghost_timer = 0.0

var is_dashing = false
var dash_timer = 0.0
var dash_direction = 0
var dash_cooldown_timer = 0.0
var is_resting = false
var face_dir = 1
# Keeps track of the heat value from the players actions (Move = +1, Jump = +2, Dash = +3)
@export var heat = 0.0
func _ready() -> void:
	default_cam_pos = cam.position

func _physics_process(delta):
	if $Pause.paused:
		return
	heat = clamp(heat, 0.0, 100.0)
	_player_heat() # Manages how the player character behaves as heat changes 
	#print(heat) # Test to see the current heat level
	if Input.is_action_pressed("rest"):
		is_resting = true
		if heat > 0.0:
			heat -= 0.1
		
	else:
		is_resting = false
			
	# Handles dashing state
	if is_dashing:
		animated_sprite.play("dash")
		dash_timer -= delta
		velocity.x = dash_direction * DASH
		velocity.y = 0 # Cancels vertical motion
		
		# Used to create dashing afterimages
		ghost_timer -= delta
		if ghost_timer <= 0:
			_create_trail()
			ghost_timer = 0.01
		
		move_and_slide()
		if dash_timer <= 0:
			is_dashing = false
		return  # Skip normal movement while dashing
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !is_resting:
		heat += 2.0
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
		face_dir = 1
	elif direction < 0:
		animated_sprite.flip_h = true
		face_dir = -1
		
	# Double tap detection
	var time = Time.get_ticks_msec() / 1000.0
	
	# Ticks down the cooldown for dash
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta
	
	if Input.is_action_just_pressed("move_left") and !is_resting:
		if time - last_tap_time["left"] < DOUBLE_TAP_TIME:
			if dash_cooldown_timer <= 0.0:
				#print("Dash left")
				_start_dash(-1) # dash left
		last_tap_time["left"] = time
		
	if Input.is_action_just_pressed("move_right") and !is_resting:
		if time - last_tap_time["right"] < DOUBLE_TAP_TIME:
			if dash_cooldown_timer <= 0.0:
				#print("Dash right")
				_start_dash(1) # dash left
		last_tap_time["right"] = time
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			if is_resting:
				animated_sprite.play("restIdle")
				cam.position = lerp(cam.position, default_cam_pos+Vector2(face_dir*10,15), .1)
			else :
				animated_sprite.play("idle")
				cam.position = lerp(cam.position, default_cam_pos+Vector2(face_dir*10,0), .7)

		else:
			if is_resting:
				animated_sprite.play("crawl")
				cam.position = lerp(cam.position, default_cam_pos+Vector2(face_dir*10,15), .1)
			else:
				animated_sprite.play("run")
				cam.position = lerp(cam.position, default_cam_pos+Vector2(face_dir*10,0), .5)
				
	else:
		animated_sprite.play("jump")
		cam.position = lerp(cam.position, default_cam_pos, .99)
	
	if heat > 0.0 && velocity.x == 0 && velocity.y == 0:
		heat -= 0.01
	
	# Apply movement
	if direction:
		if !is_resting:
			heat += 0.02
			velocity.x = direction * SPEED
		else:
			velocity.x = direction * (SPEED/2.5)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) # This slowly stops the player character (friction)
		
	hud.global_transform = cam.global_transform
	move_and_slide()
	
func _start_dash(direction):
	heat += 5.0
	is_dashing = true
	dash_timer = DASH_DURATION
	dash_direction = direction
	
func _create_trail():
	var ghost = Sprite2D.new()

	# Get the texture of the current animation frame
	var frame_tex = animated_sprite.sprite_frames.get_frame_texture(animated_sprite.animation, animated_sprite.frame)
	if frame_tex:
		ghost.texture = frame_tex
	else:
		# fallback if frame not ready yet — use first frame of current animation
		ghost.texture = animated_sprite.sprite_frames.get_frame_texture(animated_sprite.animation, 0)
	
	ghost.flip_h = animated_sprite.flip_h
	ghost.global_position = animated_sprite.global_position
	var heat_normalized = heat / 100.0
	ghost.modulate = Color(1, 1 - heat_normalized, 1 - heat_normalized)
	get_tree().current_scene.add_child(ghost)

	# Fade out and remove
	var fade_tween = create_tween()
	fade_tween.tween_property(ghost, "modulate:a", 0.0, 0.4)
	fade_tween.tween_callback(Callable(ghost, "queue_free"))
	
func _player_heat():
	var heat_normalized = heat / 100.0
	global.heat = snapped(heat,.01)
	$AnimatedSprite2D.modulate = Color(1 + heat_normalized, 1 - heat_normalized, 1 - heat_normalized)
	
func player_death():
	timer.start()

	


func _on_slow_mo_timeout() -> void:
	Engine.time_scale = 1.0
	print("death")
	get_tree().reload_current_scene()
	
