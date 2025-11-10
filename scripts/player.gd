extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const DASH = 300
const DASH_DURATION = 0.15
const DOUBLE_TAP_TIME = 0.2

var last_tap_time = { "left" : 0.0, "right": 0.0 }

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var dash_animation = preload("res://scenes/trail.tscn")
var ghost_timer = 0.0

var is_dashing = false
var dash_timer = 0.0
var dash_direction = 0

func _physics_process(delta):
	# Handles dashing state
	if is_dashing:
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
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Double tap detection
	var time = Time.get_ticks_msec() / 1000.0
	var cooldown = 1.0
	if Input.is_action_just_pressed("move_left"):
		if time - last_tap_time["left"] < DOUBLE_TAP_TIME:
			#print("Dash left")
			_start_dash(-1) # dash left
		last_tap_time["left"] = time
		
	if Input.is_action_just_pressed("move_right"):
		if time - last_tap_time["right"] < DOUBLE_TAP_TIME:
			#print("Dash right")
			_start_dash(1) # dash left
		last_tap_time["right"] = time
		
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
func _start_dash(direction):
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
	ghost.modulate = Color(1, 1, 1, 0.7)
	get_tree().current_scene.add_child(ghost)

	# Fade out and remove
	var fade_tween = create_tween()
	fade_tween.tween_property(ghost, "modulate:a", 0.0, 0.4)
	fade_tween.tween_callback(Callable(ghost, "queue_free"))
