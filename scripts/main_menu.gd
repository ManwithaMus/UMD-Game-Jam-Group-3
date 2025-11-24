extends Control

@onready var bgm = $"/root/Music/AudioStreamPlayer"
@onready var timer = $Timer
@onready var playercontrols = $Directions
var playback

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$OptionsPopup.visible = false
	AudioServer.set_bus_volume_db(0,linear_to_db(15))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_button_pressed() -> void:
	playback = bgm.get_stream_playback()
	playback.switch_to_clip_by_name(&"No Going Back")
	const INTRO = preload("res://scenes/intro.tscn")
	var intro = INTRO.instantiate()
	add_child(intro)
	timer.start()

	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	if $OptionsPopup.visible == false:
		$OptionsPopup.visible = true
		playercontrols.visible = false

	else:
		$OptionsPopup.visible = false
		playercontrols.visible = true


func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,linear_to_db(value))


func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920,1080))
		1:
			DisplayServer.window_set_size(Vector2i(1280,720))
		2:
			DisplayServer.window_set_size(Vector2i(1152,648))
		3:
			DisplayServer.window_set_size(Vector2i(800,600))


func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_close_pressed() -> void:
	$OptionsPopup.visible = false


func _on_timer_timeout() -> void:
	playback.switch_to_clip_by_name(&"No Going Back")
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
