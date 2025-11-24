extends Label

@onready var global = $"/root/Global"
var total_time = 0

func _ready() -> void:
	if global.current_level+1 == len(global.levels):
		total_time = global.get_total_time()
	
		print(global.times)
		self.text = "Time Elapsed: " + str(snapped(total_time, .01)) + " s"
	else:
		print(str(global.current_time))
		self.text = "Time : " + str(snapped(global.current_time, .01)) + " s"
