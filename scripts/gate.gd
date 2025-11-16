extends Node2D

@onready var global = $"/root/Global"
@onready var gate_anim = $AnimatableBody2D/AnimationPlayer
@onready var base = $Base

var anim_prev
@export var threshold = 30  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_prev = "open" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(anim_prev + " " + str(gate_anim.is_playing()))
	if gate_anim.is_playing() == false:
		if global.heat > threshold && anim_prev != "close":
			base.play("transition")
			base.play("on")
			gate_anim.play("close")
			anim_prev = "close"
		elif global.heat < threshold && anim_prev != "open":
			print("opening")
			base.play("transition")
			base.play("off")
			gate_anim.play("open")
			anim_prev = "open"
		else:
			pass
			

		
		
func open():
	pass
func close():
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
