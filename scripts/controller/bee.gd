extends RigidBody2D

var timer: float
var dir: Vector2
const speed_ref = 50.0
var speed: float = 50.0
var start_pos: Vector2
var is_good_throw: bool
var break_pause: float
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var impact_frames: AnimatedSprite2D = $ImpactFrames

func _process(delta: float) -> void:
	if GameManager.curr_state == GameManager.game_state.WAITING_FOR_INPUT or GameManager.is_paused:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		return

	if break_pause > 0.0:
		linear_velocity = Vector2.ZERO
		angular_velocity = 0.0
		break_pause -= delta
		return

	timer -= delta
	if timer <= 0:
		dir = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
		timer = randf_range(.75, 1.5)
		speed = speed_ref
		angular_velocity = 0.0
		rotation = 0.0
		collision_mask = 2
		if is_good_throw:
			var dist = roundi(abs(start_pos.x - global_position.x) / 100)
			GameManager.die("THREW_BEE", "Throw distance: " + str(dist) + "m")
			#if dist > 1000: GameManager.die("THREW_BEE_GREAT", "Great launch! Distance: " + str(dist) + "m")
			#else: GameManager.die("THREW_BEE", "Throw distance: " + str(dist) + "m")
			(get_viewport().get_camera_2d() as Camera).target = null
			is_good_throw = false

	if is_good_throw:
		impact_frames.scale = lerp(Vector2.ONE, Vector2.ONE * 4, timer / 3.0)
	linear_velocity = dir * speed

func _on_body_entered(body: Node) -> void:
	var stick = body as Stick
	var red = global_position - stick.end.global_position
	var throwDir = red.x
	var dir01 = -1 if throwDir < 0 else 1
	stick.push(dir01)

	angular_velocity = dir01 * 20
	var vel = stick.get_velocity()
	speed = vel * 2000.0
	dir = red.normalized()
	var cam = get_viewport().get_camera_2d() as Camera
	if vel > 0: dir.x = abs(dir.x)
	else: dir.x = -abs(dir.x)
	if speed > 10_000 && dir.y < 0 and cam.target == null: # Great throw!
		sprite_2d.hide()
		stick.is_enabled = false
		cam.target = self
		start_pos = global_position
		timer = 3.0
		is_good_throw = true
		impact_frames.show()
		impact_frames.scale = Vector2.ONE * 4
		impact_frames.play("default")
		break_pause = 0.5
		stick.break_pause = 0.5
	else:
		timer = 1.0
	collision_mask = 0

func reset_bee() -> void:
	impact_frames.scale = Vector2.ONE
