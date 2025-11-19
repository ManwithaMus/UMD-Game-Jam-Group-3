extends Node2D

# 0: off, 1: on, 2: interval, 
@export var firewall_type = 0
@export var interval_len = 1 #for timer

@onready var b1 = $beam
@onready var b2 = $base2/beam2
@onready var kz = $beam/Killzone/CollisionShape2D
@onready var timer = $Timer

var state = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = interval_len
	b1.play("start")
	b2.play("start")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match firewall_type:
		0:
			off()
		1:
			on()
		2:
			pass			
func on():
	kz.disabled = false
	b1.visible = true
	b1.play("on")	
	b2.play("on2")
	
func off():
	kz.disabled = true
	b1.visible = false
	
func _on_timer_timeout() -> void:
	#print(state)
	
	if state == false:
		b1.play("start")
		b2.play("start")
		state = true
	elif state == true:
		b1.play("start")
		b2.play("start")
		state = false
		


func _on_beam_animation_finished() -> void:
	var anim_name = b1.animation
	
	if anim_name == "start" && state == false:
		on()
	elif anim_name != "start" && state == true && firewall_type == 2:
		off()
		
		
