extends Control

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if paused:
			self.visible = false
			paused = false
		else:
			self.visible = true
			paused = true

func _on_resume_pressed() -> void:
	self.visible = false
	paused = false


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	$Confirm.visible = true


func _on_mm_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _on_nmm_pressed() -> void:
	$Confirm.visible = false


func _on_controls_pressed() -> void:
	pass # Replace with function body.
