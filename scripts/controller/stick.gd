class_name Stick extends RigidBody2D

@export var camera: Camera2D
@export var end: Node2D

const physic_multiplier = 2.0
var pushForce: float
var pushTimer = 0.0

var elapsed: float
var mov: Vector2

const deg_to_rad = 0.01745

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing():
		return

	elapsed += delta

	if pushTimer > 0.0:
		pushTimer -= delta * 2.0
		angular_velocity += pushForce * pushTimer

	if end.global_position.y < -5000 && abs(end.global_position.x) < 50.0:
		GameManager.go_to_shop()

	angular_velocity += mov.x * deg_to_rad * 1.0
	linear_velocity = (Vector2.DOWN * cos(rotation) + Vector2.LEFT * sin(rotation)) * mov.y * 300.0
	mov = Vector2.ZERO

	if abs(wrapf(rotation, -PI, PI)) > PI / 2:
		GameManager.die()

func _unhandled_input(event):
	if not GameManager.is_game_ongoing():
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		delta.y = clampf(delta.y, - PersistentData.max_speed_y,  PersistentData.max_speed_y)
		mov = delta

func get_velocity():
	return angular_velocity

func push(dir) -> void:
	pushTimer = 1.0
	pushForce = dir * 0.01
