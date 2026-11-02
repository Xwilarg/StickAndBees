extends Sprite2D

@export var camera: Camera2D

var deviation_x: float

func _ready() -> void:
	PersistentData.total_deviation = 0.0

func _process(delta: float) -> void:
	if position.y < -5000:
		PersistentData.total_deviation = deviation_x
		get_tree().change_scene_to_file("res://scenes/shop.tscn")

func _unhandled_input(event):
	if GameManager.is_paused or GameManager.curr_state != GameManager.game_state.PLAYING:
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		deviation_x += abs(delta.x)
		position += delta
