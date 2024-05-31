extends Node

class_name Damagable

@export var hp : float = 500:
	get:
		return hp
	set(value):
		SignalBus.emit_signal("on_health_changed",get_parent(), (value - hp))
		hp = value
@export var def : float = 50

@export var knockbackModifier = 2
@export var receiveKnockback: bool = true
var knockedBack = false

func recieve_knockback(damage_source_pos: Vector2, received_damage: int):
	if receiveKnockback && !get_parent().dead:
		var knockback_dir = damage_source_pos.direction_to(get_parent().global_position)
		knockback_dir = (knockback_dir/ abs(knockback_dir)) / 2
		
		var knockback_str = received_damage * knockbackModifier
		var knockback = knockback_dir * knockback_str

		get_parent().global_position.x +=  knockback.x
		knockedBack = true


func hit(damage : int):
	hp -= (damage - def)
	
	if(hp <= 0):
		get_parent().dead = true
		
