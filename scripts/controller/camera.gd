class_name Camera extends Camera2D

var target: Node2D = null
var go_up: Stick = null
var go_down: Stick = null
var zoom_flower: Node2D
var base_pos: Vector2

var zoom_step = 0
var zoom_timer = 0.0

const cloud = preload("res://scenes/prefabs/cloud.tscn")

func _ready() -> void:
	base_pos = global_position

func _process(delta: float) -> void:
	if target != null:
		global_position = target.global_position
		#global_position = lerp(global_position, target.global_position, delta * 10.0)

	if go_up != null:
		global_position.y = clamp(global_position.y - delta * 1000.0, go_up.global_position.y, global_position.y)

	if go_down != null:
		global_position.y = clamp(global_position.y + delta * 1000.0, global_position.y, go_down.global_position.y)
		if global_position.y > 10_500:
			GameManager.die("WENT_DOWN", "What a bad apple!")

	if zoom_flower != null and zoom_step < 4:
		zoom_timer -= delta
		if zoom_timer <= 0.0:
			zoom_step += 1
			zoom_timer = 0.5
			global_position = lerp(base_pos, zoom_flower.global_position, zoom_step / 4.0)
			zoom /= .9
			if zoom_step == 4:
				GameManager.die("SHOT_BEE", "Nice shot!")
