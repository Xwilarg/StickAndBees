class_name LevelManager extends Node2D

const bee = preload("res://scenes/prefabs/bee.tscn")
const cloud = preload("res://scenes/prefabs/cloud.tscn")

@export var digits: Array[Texture2D]

func _ready() -> void:
	var center = get_viewport().get_camera_2d().get_screen_center_position()
	for ach in PersistentData.achievements:
		var inst = bee.instantiate()
		inst.global_position = Vector2(randf_range(center.x - 3000.0, center.x + 3000.0), randf_range(center.y - 1000.0, center.y + 1000.0))
		add_child(inst)

	for i in range(randi_range(5, 8)):
		var inst = cloud.instantiate()
		inst.global_position = Vector2(randf_range(center.x - 5000.0, center.x + 5000.0), randf_range(-20_000, -10_000))
		inst.scale = Vector2.ONE * randf_range(.8, 2.0)
		add_child(inst)

	if PersistentData.is_right_click_run:
		get_node("/root/Root/CanvasLayer/StartingUI/LeftClick").visible = false
		get_node("/root/Root/CanvasLayer/StartingUI/RightClick").visible = true
