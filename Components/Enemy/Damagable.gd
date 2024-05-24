extends Node

class_name Damagable

@export var hp : float = 500:
	get:
		return hp
	set(value):
		SignalBus.emit_signal("on_health_changed",get_parent(), (value - hp))
		hp = value
@export var def : float = 50
@export var atk : float = 25

func _ready():
	pass 
func _process(delta):
	pass

func hit(damage : int):
	hp -= (damage - def)
	
	if(hp <= 0):
		get_parent().queue_free()
