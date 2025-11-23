extends Label

@onready var global = $"/root/Global"
var total_time

func _ready() -> void:
	if global.current_level+1 == len(global.levels):
		total_time = 0.0
		for key in global.times.keys():
			total_time += global.times[key]
		print(global.times)
		self.text = "Time Elapsed: " + str(snapped(total_time, .01)) + " s"
	else:
		self.text = "Time : " + str(snapped(global.current_time, .01)) + " s"
