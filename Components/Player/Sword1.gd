extends Area2D

@export var damage : float = 100

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damagable:
			child.hit(damage)
