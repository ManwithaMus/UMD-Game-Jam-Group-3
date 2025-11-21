extends Area2D

@onready var timer = $Timer
var player
@onready var sprite = $Sprite

func _physics_process(delta):
	const SPEED = 1000

	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	
	#if travelled_distance > RANGE:
		#queue_free()


func _on_body_entered(body):
	
	if body.has_method("player_death"):
		Engine.time_scale = 0.5
		print(Engine.time_scale)
		body.get_node("CollisionShape2D").queue_free()
		
		body.player_death()
	sprite.queue_free()
		
	



		
