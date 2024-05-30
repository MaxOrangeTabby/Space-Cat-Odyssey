extends CharacterBody2D

class_name Player

signal hit(damage_taken : float)
signal healthChanged(damage_taken : float)

@export var speed : float = 300.0
@export var jump_velocity : float = -450.0

@export var maxHealth : float = 30.0
@onready var currentHealth = maxHealth

@onready var sprite_animation : AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO
var animation_lock : bool = false # For locking run animation during jump
var attacking : bool = false # To avoid sliding during attacking

func _ready():
	hit.connect(_get_hit)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Jump Logic
	if Input.is_action_pressed("jump") and is_on_floor():
		jump()

	# Movement Logic (left/right)
	direction = Input.get_vector("move_left","move_right","jump","move_down")
	if direction.x != 0  && !attacking:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)	
		
	# Attack Logic
	if Input.is_action_pressed("primary_attack") && (sprite_animation.animation != "jump"):
			attack()

	move_and_slide()
	update_animation()


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "jump":
		animation_lock = false
	if $AnimatedSprite2D.animation == "primary_attack":
		if($AnimatedSprite2D.flip_h):
			$AttackArea/AttackAreaLeft.disabled = true
		else:
			$AttackArea/AttackAreaRight.disabled = true
		attacking = false
 
func attack():
	if($AnimatedSprite2D.flip_h):
		$AttackArea/AttackAreaLeft.disabled = false
	else:
		$AttackArea/AttackAreaRight.disabled = false
	sprite_animation.play("primary_attack")
	attacking = true

func jump():
	velocity.y = jump_velocity
	sprite_animation.play("jump")
	animation_lock = true

func _get_hit(damage_taken):
	healthChanged.emit(damage_taken)
	
func update_animation():
	if not animation_lock:
		if direction.x != 0 && !attacking:
			sprite_animation.play("run")
			sprite_animation.flip_h = velocity.x < 0
		elif !attacking:
			sprite_animation.play("idle")

	



