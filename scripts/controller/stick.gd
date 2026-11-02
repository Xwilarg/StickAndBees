extends Sprite2D

@export var camera: Camera2D

var deviation_x: float

func _process(delta: float) -> void:
	if position.y < -5000:
		GameManager.go_to_shop(deviation_x)

func _unhandled_input(event):
	if GameManager.is_paused or GameManager.curr_state != GameManager.game_state.PLAYING:
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		deviation_x += abs(delta.x)
		position += delta
