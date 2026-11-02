class_name Camera extends Camera2D

var target: Node2D = null

func _process(_delta: float) -> void:
	if target != null:
		global_position = target.global_position
