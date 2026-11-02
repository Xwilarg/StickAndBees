extends Node2D

const bee = preload("res://scenes/prefabs/bee.tscn")

func _ready() -> void:
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	for ach in PersistentData.achievements:
		var inst = bee.instantiate()
		inst.global_position = Vector2(randf_range(center.x - 3000.0, center.x + 3000.0), randf_range(center.y - 1000.0, center.y + 1000.0))
		add_child(inst)
