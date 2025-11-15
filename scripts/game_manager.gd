extends Node

var level_1 = "res://scenes/levels/level_1.tscn"
var level_2 = "res://scenes/levels/level_2.tscn"
var score = 0

var levels = [level_1, level_2]
var current_level = 0
@onready var score_label = $ScoreLabel

#func add_point():
	#score += 1
	#score_label.text = "You collected " + str(score) + " coins."

func level_end():
	print("end")
	#var tree = get_tree()
	#var cur_scene = tree.get_current_scene()
	#tree.get_root().add_child(levels[current_level+1])	
	#tree.get_root().remove_child(cur_scene)
	#tree.set_current_scene(levels[current_level+1])
	get_tree().change_scene_to_file(levels[current_level+1])
	print(current_level+1)
	current_level += 1
