extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("damaged", get_parent().atk)
		
