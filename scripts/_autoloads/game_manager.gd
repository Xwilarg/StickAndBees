extends Node2D

enum game_state { WAITING_FOR_INPUT, PLAYING }

var curr_state: game_state = game_state.WAITING_FOR_INPUT
var is_paused: bool = false

func _ready() -> void:
	get_node("/root/Root/CanvasLayer/PauseUI").visible = false

func _process(_delta: float) -> void:
	if curr_state == game_state.WAITING_FOR_INPUT:
		if Input.is_action_just_pressed("confirm"):
			get_node("/root/Root/CanvasLayer/StartingUI").queue_free()
			curr_state = game_state.PLAYING

	if Input.is_action_just_pressed("pause"):
		is_paused = not is_paused
		get_node("/root/Root/CanvasLayer/PauseUI").visible = is_paused

	if not is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
