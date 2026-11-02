extends Sprite2D

@export var camera: Camera2D

var deviation_x: int

func _process(delta: float) -> void:
	if position.y < -5000:
		GameManager.go_to_shop(deviation_x)

func _unhandled_input(event):
	if GameManager.is_paused or GameManager.curr_state != GameManager.game_state.PLAYING:
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		delta.y = clampf(delta.y, - PersistentData.max_speed_y,  PersistentData.max_speed_y)
		deviation_x += abs(roundi(delta.x))
		position += delta
