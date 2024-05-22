extends CharacterBody2D

@export var knockbackModifier = 2
@export var receiveKnockback: bool = true
@export var starting_move_direction : Vector2 = Vector2.LEFT

@onready var enemy_animation : AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var knockedBack = false
var enemySpeed = 40

var hp = 500
var dead = false 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var direction : Vector2 = starting_move_direction
	if direction: 
		velocity.x = direction.x * enemySpeed
		enemy_animation.play("walk")
	else:
		velocity.x =  move_toward(velocity.x, 0, enemySpeed)
	move_and_slide()


func recieve_knockback(damage_source_pos: Vector2, received_damage: int):
	if receiveKnockback:
		var knockback_dir = damage_source_pos.direction_to(self.global_position)
		knockback_dir = (knockback_dir/ abs(knockback_dir)) / 2
		
		var knockback_str = received_damage * knockbackModifier
		var knockback = knockback_dir * knockback_str

		global_position.x +=  knockback.x
		 
		knockedBack = true


func _on_hitbox_area_area_entered(area):
	recieve_knockback(area.global_position, 100)
	if area.is_in_group("Sword"):
		dead = true;
		$AnimatedSprite2D.play("death");


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		queue_free();
