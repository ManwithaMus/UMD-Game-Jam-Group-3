extends Node2D

# 0: off, 1: on, 2: interval, 
@export var firewall_type = 0
@export var interval_len = .5 #for timer
@export var interval2_len = 1 #for timer2


@onready var b1 = $beam
@onready var b2 = $base2/beam2
@onready var kz = $beam/Killzone/CollisionShape2D
@onready var timer = $Timer
@onready var timer2 = $Timer2

var state #true if firewall active
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state = true
	timer.wait_time = interval_len
	timer2.wait_time = interval2_len
	
	timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match firewall_type:
		0:
			off()
		1:
			on()
		2:
			#print(state)
			if state:
				on()
			else:
				off()
			
func on():
	#print("on?")
	kz.disabled = false
	b1.visible = true
	b2.visible = true
	b1.play("on")	
	b2.play("on2")
	
func off():
	print("off")
	kz.disabled = true
	b1.visible = false
	b2.visible = false
	if firewall_type == 2:
		timer.start()
	
func _on_timer_timeout() -> void:
	#print(b1.animation, state)
	
	if state:
		state = false
		timer2.start()
		
	else:
		state = true
		

func _on_timer_2_timeout() -> void:
	#print("timer2")
	state = true
	timer.start()
#func _on_beam_animation_finished() -> void:
	#var anim_name = b1.animation
	#print("finished: ", anim_name, " ", state)
	#
	#if anim_name == "start" && state == false:
		#on()
		#
	#elif anim_name == "start" && state == true && firewall_type == 2:
		#print("off")
		#off()
		
		
		
		
