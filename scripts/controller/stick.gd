class_name Stick extends Area2D

@export var camera: Camera2D
@export var end: Node2D

const physic_multiplier = 2.0
var pushForce: float
var pushTimer = 0.0

const deg_to_rad = 0.01745

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing():
		return

	if pushTimer > 0.0:
		pushTimer -= delta * 2.0
		rotation += pushForce * pushTimer

	rotation += rotation * delta * physic_multiplier
	if end.global_position.y < -5000 && abs(end.global_position.x) < 50.0:
		GameManager.go_to_shop()

func _unhandled_input(event):
	if not GameManager.is_game_ongoing():
		return
	
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative
		delta.y = clampf(delta.y, - PersistentData.max_speed_y,  PersistentData.max_speed_y)
		rotate(delta.x * deg_to_rad * .1)
		#deviation_x += abs(roundi(delta.x))
		position += (Vector2.DOWN * cos(rotation) + Vector2.LEFT * sin(rotation)) * delta.y
		if abs(rotation) > 1:
			GameManager.die()

func push(dir) -> void:
	pushTimer = 1.0
	pushForce = dir * 0.01
