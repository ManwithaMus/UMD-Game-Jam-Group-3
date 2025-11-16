extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	print("pickup")
	game_manager.level_end()
	#animation_player.play("pickup")
