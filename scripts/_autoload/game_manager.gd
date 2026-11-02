extends Node2D

enum game_state { WAITING_FOR_INPUT, PLAYING, SHOP }

var curr_state: game_state = game_state.WAITING_FOR_INPUT
var is_paused: bool = false

func _ready() -> void:
	PersistentData.total_deviation = 0.0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_node("/root/Root/CanvasLayer/PauseUI").visible = false

func _process(_delta: float) -> void:
	if curr_state == game_state.WAITING_FOR_INPUT and Input.is_action_just_pressed("confirm"):
		get_node("/root/Root/CanvasLayer/StartingUI").queue_free()
		curr_state = game_state.PLAYING

	if curr_state == game_state.PLAYING and Input.is_action_just_pressed("pause"):
		is_paused = not is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED
		get_node("/root/Root/CanvasLayer/PauseUI").visible = is_paused

func go_to_shop(deviation: float):
	PersistentData.total_deviation = deviation
	PersistentData.money += roundi(200 - deviation)
	GameManager.curr_state = GameManager.game_state.SHOP
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
