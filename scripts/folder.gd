extends Area2D

var popup1

@onready var fmax = 1
var num_pop = 0

#func _ready() -> void:
	#pass


#func _process(delta: float) -> void:
	#pass


func _on_body_entered(body: Node2D) -> void:
	const POPUP =  preload("res://scenes/objects/popup.tscn")

	if num_pop < self.fmax:
		if body is CharacterBody2D:
			popup1 = POPUP.instantiate()
			popup1.position = Vector2(0,-10)
			self.add_child(popup1)
			num_pop += 1


func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
			popup1.queue_free()
			num_pop -= 1
