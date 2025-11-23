extends Node



var heat = 0.0
var current_time
var times = {}

@onready var bgm = "res://scenes/music.tscn"

var level_1 = "res://scenes/levels/level_1.tscn"
var level_2 = "res://scenes/levels/level_2.tscn"
var level_3 = "res://scenes/levels/level_3.tscn"
var end = "res://scenes/end_screen.tscn"
var score = 0

var levels = [level_1, level_2, level_3, end]
var bgm_paths = {-1: "res://assets/music/pothos2.mp3", 1: "res://assets/music/no going back(1).mp3"}
var current_level = -1

#@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_level_time(level = current_level):
	return levels[level]
	
func level_end():	 
	current_level = levels.find(get_tree().current_scene.scene_file_path)
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
	
	
func level_next():
	if current_level+1 != len(levels):
		print(current_level)
		get_tree().change_scene_to_file(levels[current_level+1])
		current_level += 1
	else:
		#end_credits or cutscene or smthn 
		print("congrats")
