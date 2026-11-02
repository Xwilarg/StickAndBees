extends Sprite2D

@export var camera: Camera2D

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var delta: Vector2 = event.relative 
		print(delta)
