extends RigidBody2D

var timer: float
var dir: Vector2
const speed_ref = 50.0
var speed = 50.0

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing():
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		return

	timer -= delta
	if timer <= 0:
		dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		timer = randf_range(.75, 1.5)
		speed = speed_ref
		angular_velocity = 0.0
		rotation = 0.0
		collision_mask = 2

	linear_velocity = dir * speed

func _on_body_entered(body: Node) -> void:
	var stick = body as Stick
	var red = global_position - stick.end.global_position
	var throwDir = red.x
	var dir01 = -1 if throwDir < 0 else 1
	stick.push(dir01)

	angular_velocity = dir01 * 20
	speed = stick.get_velocity() * 2000.0
	dir = red.normalized()
	if speed > 10_000 && dir.y < 0:
		stick.is_enabled = false
		(get_viewport().get_camera_2d() as Camera).target = self
		timer = 3.0
	else:
		timer = 1.0
	collision_mask = 0
