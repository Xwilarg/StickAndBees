extends Area2D

@export var cam: Camera

func _on_body_entered(body: Node2D) -> void:
	var bee = body as Bee
	body.set_deferred("freeze", true)
	
	if GameManager.is_game_ongoing():
		GameManager.curr_state = GameManager.game_state.PENDING_ENDING
		cam.zoom_flower = body
