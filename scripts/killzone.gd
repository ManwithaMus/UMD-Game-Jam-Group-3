extends Area2D

@onready var timer = $Timer
var player

func _on_body_entered(body):
	#print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	player = body
	body.player_death()
	timer.start()



	
	
