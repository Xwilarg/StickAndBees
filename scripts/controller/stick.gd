class_name Stick extends Area2D

@export var camera: Camera2D
@export var end: Node2D

const physic_multiplier = 2.0
var pushForce: float
var pushTimer = 0.0
var lastRot: float
var newRot: float

var elapsed: float

const deg_to_rad = 0.01745

var velocities: Array[VelByTime] = []

func _process(delta: float) -> void:
	if not GameManager.is_game_ongoing():
		return

	elapsed += delta

	if newRot != lastRot:
		velocities.push_back(VelByTime.new(newRot, elapsed))
	newRot = lastRot

	while velocities.size() > 0 and velocities[0].time < elapsed - .5:
		velocities.remove_at(0)

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
		newRot = rotation
		#deviation_x += abs(roundi(delta.x))
		position += (Vector2.DOWN * cos(rotation) + Vector2.LEFT * sin(rotation)) * delta.y
		if abs(wrapf(rotation, -PI, PI)) > PI / 2:
			GameManager.die()

func get_velocity():
	return velocities.map(func(e: VelByTime): return e.velocity).reduce(func(accum, nb): return accum + nb)

func push(dir) -> void:
	pushTimer = 1.0
	pushForce = dir * 0.01
