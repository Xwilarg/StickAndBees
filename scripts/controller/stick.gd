class_name Stick extends RigidBody2D

@export var camera: Camera2D
@export var end: Node2D

const physic_multiplier = 2.0
var pushForce: float
var pushTimer = 0.0

var elapsed: float
var mov: Vector2
var rot = 0.0
var break_pause: float

var is_enabled: bool = true

const deg_to_rad = 0.01745

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing():
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		return

	if break_pause > 0.0:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		break_pause -= delta
		return

	elapsed += delta

	if pushTimer > 0.0:
		pushTimer -= delta * 2.0
		angular_velocity += pushForce * pushTimer

	if end.global_position.y < -5000 && abs(end.global_position.x) < 50.0:
		GameManager.die("GOT_HONEY", "You got the honey!")

	rot += mov.x * deg_to_rad * 1.0
	angular_velocity = rot
	linear_velocity = (Vector2.DOWN * cos(rotation) + Vector2.LEFT * sin(rotation)) * mov.y * 300.0
	mov = Vector2.ZERO

	if is_enabled and abs(wrapf(rotation, -PI, PI)) > PI / 2:
		GameManager.die("LOST_STICK", "You lost your stick!")

func _unhandled_input(event):
	if not GameManager.is_game_ongoing() or not is_enabled:
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		delta.y = clampf(delta.y, - PersistentData.max_speed_y,  PersistentData.max_speed_y)
		mov = delta

func get_velocity() -> float:
	return angular_velocity

func push(dir) -> void:
	pushTimer = 1.0
	pushForce = dir * 0.01
