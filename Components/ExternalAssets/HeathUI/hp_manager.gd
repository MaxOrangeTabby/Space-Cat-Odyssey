extends Control

@export var health_change_label : PackedScene
@export var damage_color : Color = Color.RED
@export var heal_color : Color = Color.GREEN

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)
	
func on_signal_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_change_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
	
	if(amount_changed >= 0):
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
