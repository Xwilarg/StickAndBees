extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	GameManager.die("GOT_HONEY", "You got the honey!")
