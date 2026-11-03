extends Node2D

enum game_state { WAITING_FOR_INPUT, PLAYING, PENDING_ENDING, SHOP }
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

	if curr_state == game_state.WAITING_FOR_INPUT:
		if Input.is_action_just_pressed("confirm"):
			get_node("/root/Root/CanvasLayer/StartingUI").visible = false
			curr_state = game_state.PLAYING
		if PersistentData.is_right_click_run and Input.is_action_just_pressed("confirm_ach"):
			die("RIGHT_CLICK", "Thank you for reading!")

	if curr_state == game_state.PLAYING and Input.is_action_just_pressed("pause"):
		is_paused = not is_paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if is_paused else Input.MOUSE_MODE_CAPTURED
		get_node("/root/Root/CanvasLayer/PauseUI").visible = is_paused

func go_to_shop():
	GameManager.curr_state = GameManager.game_state.SHOP
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func die(ach: String, text: String):
	PersistentData.unlock_achievement(ach)
	get_node("/root/Root/CanvasLayer/LostUI").visible = true
	(get_node("/root/Root/CanvasLayer/LostUI/Text") as Label).text = text
	get_node("/root/Root/CanvasLayer/StartingUI").visible = false
	PersistentData.runs_since_right_click_ach += 1
	PersistentData.is_right_click_run = PersistentData.runs_since_right_click_ach >= 5 and randi_range(0, 10) == 0
	if PersistentData.is_right_click_run: PersistentData.runs_since_right_click_ach = 0

	go_to_shop()

func is_game_ongoing() -> bool:
	return curr_state == game_state.PLAYING and not is_paused
