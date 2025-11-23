extends Area2D

@onready var sprite = $Sprite2D
var player
var scale1 = scale
var scale2 = scale * 1.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body):
	#print("You died!")
	if body.has_method("player_death"):
		Engine.time_scale = 0.5
		
		body.get_node("CollisionShape2D").queue_free()
		body.player_death()


func _on_timer_timeout() -> void:
	if scale != scale1:
		scale = scale1
	else:
		scale = scale2
