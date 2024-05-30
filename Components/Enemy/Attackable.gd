extends Area2D


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.emit_signal("hit", get_parent().atk)
		
