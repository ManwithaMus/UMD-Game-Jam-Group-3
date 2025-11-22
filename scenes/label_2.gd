extends Label

@onready var global = $"/root/Global"

func _ready() -> void:
	self.text = "Time : " + str(int(global.current_time)/60) + ":" + str(int(global.current_time)%60)
