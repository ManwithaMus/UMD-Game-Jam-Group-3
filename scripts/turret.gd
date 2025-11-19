extends Area2D

#@onready var test = $"../test"


@onready var raycast = $RayCast2D
var target_visible 

func _process(_delta):
	var targets = get_overlapping_bodies()
	if targets.size() > 0:
		var targets_enemy = targets.front()
		look_at(targets_enemy.global_position)		
		if raycast.get_collider() is CharacterBody2D: 
			target_visible = true
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
	if target_visible:	
		shoot()
