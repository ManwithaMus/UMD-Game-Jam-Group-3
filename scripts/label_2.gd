extends Label

@onready var global = $"/root/Global"
var total_time

func _ready() -> void:
	if global.current_level+1 == len(global.levels):
		total_time = 0.0
		for key in global.times.keys():
			total_time += global.times[key]
		print(global.times)
		self.text = "Total Time\n" + str(int(total_time)/60) + ":" + str(int(total_time)%60)
	else:
		self.text = "Time : " + str(int(global.current_time)/60) + ":" + str(int(global.current_time)%60)
