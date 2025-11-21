extends Node2D

@onready var global = $"/root/Global"
@onready var gate_anim = $AnimatableBody2D/AnimationPlayer
@onready var base = $StaticBody2D/Base

var anim_prev
@export var state = false  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_prev = "open" # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(anim_prev + " " + str(gate_anim.is_playing()))
	if gate_anim.is_playing() == false:
		if state && anim_prev == "open":
			base.play("transition")
			base.play("on")
			gate_anim.play("close")
			anim_prev = "close"
		elif state:
			#print("opening")
			#base.play("transition")
			#base.play("off")
			#gate_anim.play("open")
			#anim_prev = "open"
			pass
		else:
			pass
			
func open():
	pass
func close():
	pass




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.


func _on_trap_area_body_entered(body: Node2D) -> void:
	if body.has_method("player_death") && global.heat > 80:
			state=true
