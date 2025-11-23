extends Node

@onready var bgm = $AudioStreamPlayer.get_stream_playback()
@onready var global =  $"/root/Global"

@export var stream_selected = 0
#var current_track : AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	pass
