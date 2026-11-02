extends Sprite2D

var timer: float
var dir: Vector2
const speed_ref = 5.0
var speed = 5.0
var rot: float

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing(): return

	timer -= delta
	if timer <= 0:
		dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		timer = randf_range(.75, 1.5)
		rot = 0.0
		speed = speed_ref
		rotation = 0.0

	position += dir * speed
	rotate(rot)

func _on_area_2d_area_entered(area: Area2D) -> void:
	var red = global_position - area.global_position
	var throwDir = red.x
	var dir01 = -1 if throwDir < 0 else 1
	var stick = area as Stick
	stick.push(dir01)

	rot = dir01 * 0.1
	timer = 1.0
	dir = red.normalized()
	speed = stick.get_velocity()
