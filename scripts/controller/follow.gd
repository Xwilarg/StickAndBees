extends Node2D

@export var follow: Node2D

var offset: Vector2

func _ready() -> void:
	offset = global_position - follow.global_position

func _process(delta: float) -> void:
	global_position = follow.global_position + offset
