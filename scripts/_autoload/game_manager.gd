extends Node2D

enum game_state { WAITING_FOR_INPUT, PLAYING, SHOP }
const min_money_added = 50
const added_money_against = 200

var curr_state: game_state = game_state.WAITING_FOR_INPUT
var is_paused: bool = false

func _ready() -> void:
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

func go_to_shop(deviation: int):
	GameManager.curr_state = GameManager.game_state.SHOP
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	print("won")
