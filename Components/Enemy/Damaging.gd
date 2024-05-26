extends Node

class_name Damaging

@export var atk : float = 25



func _on_collision_shape_2d_child_entered_tree(node):
	print(node)


func _on_collision_shape_2d_child_exiting_tree(node):
	print(node)
