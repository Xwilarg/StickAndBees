class_name Camera extends Camera2D

var target: Node2D = null
var go_up: Stick = null
var go_down: Stick = null

func _process(delta: float) -> void:
	if target != null:
		global_position = target.global_position
		#global_position = lerp(global_position, target.global_position, delta * 10.0)

	if go_up != null:
		global_position.y = clamp(global_position.y - delta * 1000.0, go_up.global_position.y, global_position.y)

	if go_down != null:
		global_position.y = clamp(global_position.y + delta * 1000.0, global_position.y, go_down.global_position.y)
		if global_position.y > 10_500:
			GameManager.die("WENT_DOWN", "Such a bad apple!")
