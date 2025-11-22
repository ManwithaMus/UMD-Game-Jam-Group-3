extends Node

@onready var global = $"/root/Global"

var level_1 = "res://scenes/levels/level_1.tscn"
var level_2 = "res://scenes/levels/level_2.tscn"
var level_3 = "res://scenes/levels/level_3.tscn"
var score = 0

var levels = [level_1, level_2, level_3]
var current_level 
var level_time
#@onready var score_label = $ScoreLabel
func _ready() -> void:
	level_time = 0
	global.current_time = level_time
func _process(delta: float) -> void:
	level_time += delta
	global.current_time = level_time
#func add_point():
	#score += 1
	#score_label.text = "You collected " + str(score) + " coins."

func level_end(): 
	print(current_level, len(levels))
	global.times[current_level] = level_time
	
	if current_level+1 != len(levels):
		print(current_level)
		get_tree().change_scene_to_file(levels[current_level+1])
		current_level += 1
	else:
		#end_credits or cutscene or smthn 
		print("congrats")
		
