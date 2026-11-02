extends Sprite2D

var timer: float
var dir: Vector2
const speed = 5.0

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing(): return

	timer -= delta
	if timer <= 0:
		dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		timer = randf_range(.75, 1.5)

	position += dir * speed
