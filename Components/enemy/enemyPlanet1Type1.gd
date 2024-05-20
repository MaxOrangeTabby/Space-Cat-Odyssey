extends RigidBody2D

@export var knockbackModifier = 2
@export var receiveKnockback: bool = true
var knockedBack = false

var enemySpeed = -1.5

var hp = 500
var dead = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!knockedBack):
		linear_velocity.x += enemySpeed 
		$AnimatedSprite2D.play("walk")
	if(knockedBack):
		knockedBack = false

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func recieve_knockback(damage_source_pos: Vector2, received_damage: int):
	if receiveKnockback:
		var knockback_dir = damage_source_pos.direction_to(self.global_position)
		knockback_dir = (knockback_dir/ abs(knockback_dir)) / 2
		
		var knockback_str = received_damage * knockbackModifier
		var knockback = knockback_dir * knockback_str

		global_position.x +=  knockback.x
		global_position.y -= 100
		
		knockedBack = true


func _on_hitbox_area_area_entered(area):
	recieve_knockback(area.global_position, 100)
	if area.is_in_group("Sword"):
		dead = true;
		$AnimatedSprite2D.play("death");


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		queue_free();
