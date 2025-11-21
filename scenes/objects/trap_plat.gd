extends AnimatableBody2D

@export var platform_type =1
@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var global = $"/root/Global"

@export var interval = 2
@export var release_interval = 1
var state

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match platform_type:
			0:
				collision.disabled = true
				sprite.modulate = Color(1,1,1,0)
			1:
				collision.disabled = false
			2:
				timer.wait_time = interval
				timer2.wait_time = release_interval
				state = true
				collision.disabled = not state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(platform_type)
	match platform_type:
		0:
			pass
		1:
			pass
		2:
			if timer.is_stopped():
				timer.start()
			collision.disabled = not state
			sprite.self_modulate = Color(1,1,1, lerp(int(not state), int(state), 1))
			
func _on_timer_timeout() -> void:
	#print(state)
	if state == true:
		state = false
		timer2.start()
	elif state == false:
		pass
	#print(str(state))
		


func _on_timer_2_timeout() -> void:
	state = true
	timer.start()


func _on_trap_area_body_entered(body: Node2D) -> void:
	if body.has_method("player_death") && global.heat > 80:
		platform_type = 0
