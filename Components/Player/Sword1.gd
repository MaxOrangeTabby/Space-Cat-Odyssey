extends Area2D

@export var damage : int = 100

func _on_body_entered(body):
	for child in body.get_children():
		if child is Damagable:
			child.hit(damage)
			# Knockback logic
			if((get_parent().get_node("AnimatedSprite2D")).flip_h):
				child.recieve_knockback(Vector2(1,0), damage)
			else:
				child.recieve_knockback(Vector2(-1,0), damage)
