extends Area2D

@onready var timer = $Timer
var player
@onready var sprite = $Sprite
const SPEED = 800

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * SPEED * delta
	
	


func _on_body_entered(body):
	print(str(body))
	if body.has_method("player_death"):
		Engine.time_scale = 0.5
		#print(Engine.time_scale)
		body.get_node("CollisionShape2D").queue_free()
		
		body.player_death()
	if is_instance_valid(sprite):
		sprite.queue_free()
	queue_free()
	



		
