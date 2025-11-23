extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	#game_manager.add_point()
	if "heat" in body:
		body.heat /= 2
		animation_player.play("pickup")
