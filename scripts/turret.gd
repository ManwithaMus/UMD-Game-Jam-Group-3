extends Area2D

#@onready var test = $"../test"

var reload_time = 1.3
var turret_range = 320

@onready var timer = $Timer
@onready var raycast = $RayCast2D
@onready var barrel = $Barrel
@onready var trange = $turret_range
@onready var global = $"/root/Global"
@onready var circle = $turret_range/Sprite2D

var target_visible 

func _ready() -> void:
	timer.wait_time = reload_time
	trange.shape.radius = turret_range
	circle.texture.width = turret_range*2
	circle.texture.height = turret_range*2
	
func _process(_delta):
	#print(circle.texture.width)
	#trange.shape.radius = turret_range * (1+global.heat/200)
	#circle.scale = Vector2(turret_range,turret_range) * (1+global.heat/200)
	
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
