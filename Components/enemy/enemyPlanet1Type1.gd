extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var atk : float = 25
var atkRange : float = 65

@onready var enemy_animation : AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dead = false 
var attacking = false
const attackFrame = 3

var enemySpeed = 40
@onready var player = get_tree().get_nodes_in_group("player")[0]


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var direction : Vector2 = starting_move_direction
	
	if dead:
		death()
		
	if !dead:
		if direction && !dead && !attacking: 
			velocity.x = direction.x * enemySpeed
			enemy_animation.play("walk")
		else:
			velocity.x =  move_toward(velocity.x, 0, enemySpeed)
		if(abs(position.x - player.position.x) <= atkRange):
			attack()
			if enemy_animation.frame == attackFrame:
				_activate_attackArea()
	move_and_slide()


func attack():
	enemy_animation.play("attack")
	attacking = true
	
func _activate_attackArea():
	$AttackArea/CollisionShape2D.disabled = false

func death():
	enemy_animation.play("death")


func _on_animated_sprite_2d_animation_finished():
	if enemy_animation.animation == "death":
		queue_free()
	if enemy_animation.animation == "attack":
		attacking = false
		$AttackArea/CollisionShape2D.disabled = true

