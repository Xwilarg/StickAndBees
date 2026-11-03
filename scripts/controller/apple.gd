extends RigidBody2D

@export var camera: Camera
@export var stick: Stick

func _on_body_entered(_body: Node) -> void:
	collision_mask = 0
	gravity_scale = 100.0
	if camera.go_up == null:
		camera.go_down = stick
