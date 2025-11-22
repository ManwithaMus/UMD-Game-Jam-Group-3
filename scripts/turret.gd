extends Area2D

#@onready var test = $"../test"

@export var reload_time = 1.3
@onready var timer = $Timer
@onready var raycast = $RayCast2D
@onready var barrel = $Barrel
var target_visible 

func _ready() -> void:
	timer.wait_time = reload_time

func _process(_delta):
	var targets = get_overlapping_bodies()
	if targets.size() > 0:
		var targets_enemy = targets.front()
		for val in targets:
			if targets is CharacterBody2D:
				targets_enemy = val
		look_at(targets_enemy.global_position)		
		if raycast.get_collider() is CharacterBody2D: 
			target_visible = true
			if timer.is_stopped():
				timer.start()
			barrel.play("charging")
			barrel.speed_scale += .01
			
			
	else:
		rotation = lerp_angle(rotation, 0, .001)
		target_visible = false
#look_at(get_global_mouse_position())
	


func shoot():
	const BULLET = preload("res://scenes/objects/bullet_2d.tscn")
	var new_bullet1 = BULLET.instantiate()
	var new_bullet2 = BULLET.instantiate()
	new_bullet1.global_transform = %bullet_point1.global_transform
	
	new_bullet2.global_transform = %bullet_point2.global_transform
	%bullet_point1.add_child(new_bullet1)
	%bullet_point2.add_child(new_bullet2)
	

func _on_timer_timeout() -> void:
	barrel.stop()
	barrel.speed_scale = 1
	if target_visible:	
		shoot()
	timer.stop()
