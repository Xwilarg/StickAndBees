extends Node2D

@export var camera: Camera2D

var deviation_x: int

const deg_to_rad = 0.01745

func _process(delta: float) -> void:
	if position.y < -5000 && abs(position.x) < 2.0:
		GameManager.go_to_shop(deviation_x)

func _unhandled_input(event):
	if GameManager.is_paused or GameManager.curr_state != GameManager.game_state.PLAYING:
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		delta.y = clampf(delta.y, - PersistentData.max_speed_y,  PersistentData.max_speed_y)
		rotate(delta.x * deg_to_rad * .1)
		deviation_x += abs(roundi(delta.x))
		position += (Vector2.DOWN * cos(rotation) + Vector2.LEFT * sin(rotation)) * delta.y
		if abs(rotation) > 1:
			print("dead")
