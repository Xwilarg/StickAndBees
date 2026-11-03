extends RigidBody2D

@export var camera: Camera
@export var stick: Stick

func _on_body_entered(body: Node) -> void:
	collision_mask = 0
	gravity_scale = 100.0
	camera.go_down = stick
