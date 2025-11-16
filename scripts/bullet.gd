extends Area2D


var travelled_distance = 0

@onready var timer = $Timer

#func _physics_process(delta):
	#const bullet_speed = 1000
	#const bullet_range = 1200
	#position += Vector2.RIGHT.rotated(rotation) * bullet_speed * delta
	#
	#travelled_distance += bullet_speed * delta
	#
	#if travelled_distance > bullet_range:
		#queue_free()


func _on_body_entered(body):
	queue_free()
	if body is CharacterBody2D:
		body.player_death()
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
