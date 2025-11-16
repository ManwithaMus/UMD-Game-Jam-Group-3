extends Area2D

func _process(_delta):
	#var targets = get_overlapping_bodies()
	#if targets.size() > 0:
	#var targets_enemy = targets.front()
	look_at(get_global_mouse_position())

#look_at(get_global_mouse_position())
	


func shoot():
	const BULLET = preload("res://scenes/objects/bullet_2d.tscn")
	var new_bullet1 = BULLET.instantiate()
	#var new_bullet2 = BULLET.instantiate()
	new_bullet1.global_transform = %bullet_point_t.global_transform
	#new_bullet2.global_transform = %bullet_point2.global_transform
	%bullet_point_t.add_child(new_bullet1)
	#%bullet_point2.add_child(new_bullet2)
	

func _on_timer_timeout() -> void:
	shoot()
