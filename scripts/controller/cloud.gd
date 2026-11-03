extends Sprite2D

var dir: float
var speed: float

func _ready() -> void:
	dir = -1.0 if randi_range(0, 1) == 0 else 1.0
	speed = randf_range(.1, 1)

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT * speed * dir
