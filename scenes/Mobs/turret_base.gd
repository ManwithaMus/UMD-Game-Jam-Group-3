extends Node2D

@onready var barrel = $Area2D

@export var reload_time = 1.3
@export var turret_range = 320

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barrel.reload_time = reload_time
	barrel.turret_range = turret_range
