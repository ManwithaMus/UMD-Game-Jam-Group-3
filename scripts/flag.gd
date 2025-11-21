extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer
@onready var global = $"/root/Global"

func _on_body_entered(body):
	global.level_end()
	#animation_player.play("pickup")


		
