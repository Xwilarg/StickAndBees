extends Sprite2D

var timer: float
var dir: Vector2
const speed_ref = 5.0
var speed = 5.0
var rot: float
var is_hit: bool

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing(): return

	timer -= delta
	if timer <= 0:
		dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		timer = randf_range(.75, 1.5)
		rot = 0.0
		speed = speed_ref
		rotation = 0.0
		is_hit = false

	position += dir * speed
	rotate(rot)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_hit: return
	
	var stick = body as Stick
	var red = global_position - stick.end.global_position
	var throwDir = red.x
	var dir01 = -1 if throwDir < 0 else 1
	stick.push(dir01)

	rot = dir01 * 0.1
	timer = 1.0
	speed = stick.get_velocity() * 4.0
	dir = red.normalized()
	dir.x = -dir.x
	is_hit = true
