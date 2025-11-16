extends Area2D

var target 
var target_visible
var current_speed
@export var speed1 = 100 
@export var speed2 = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target_visible:
		position += Vector2.RIGHT.rotated(rotation) * current_speed * delta
		look_at(target.global_position)
	else:
		position += Vector2.RIGHT.rotated(rotation) * current_speed/2 * delta

func _on_timer_timeout() -> void:
	if current_speed == speed1:
		current_speed = speed2
	elif current_speed == speed2:
		current_speed = speed1
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	var targets = get_overlapping_bodies()
	if targets.size() > 0:
		target = targets.front()
		
		target_visible = true
	else:
		target_visible = false
