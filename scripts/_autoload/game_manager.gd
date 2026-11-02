extends Node2D

enum game_state { WAITING_FOR_INPUT, PLAYING, SHOP }
const min_money_added = 50
const added_money_against = 200

var curr_state: game_state = game_state.WAITING_FOR_INPUT
var is_paused: bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	curr_state = game_state.WAITING_FOR_INPUT

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		_ready()
		get_tree().reload_current_scene()

	if curr_state == game_state.WAITING_FOR_INPUT and Input.is_action_just_pressed("confirm"):
		get_node("/root/Root/CanvasLayer/StartingUI").queue_free()
		curr_state = game_state.PLAYING

	if curr_state == game_state.PLAYING and Input.is_action_just_pressed("pause"):
		is_paused = not is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED
		get_node("/root/Root/CanvasLayer/PauseUI").visible = is_paused

func go_to_shop():
	GameManager.curr_state = GameManager.game_state.SHOP
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func die():
	get_node("/root/Root/CanvasLayer/LostUI").visible = true
	go_to_shop()


func is_game_ongoing() -> bool:
	return curr_state == game_state.PLAYING and not is_paused
