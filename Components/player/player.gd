extends CharacterBody2D
signal hit

@export var speed : float = 300.0
@export var jump_velocity : float = -450.0

@onready var sprite_animation : AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction : Vector2 = Vector2.ZERO
var animation_lock : bool = false
var attacking : bool = false



func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Jump Logic
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Movement Logic (left/right)
	direction = Input.get_vector("move_left","move_right","jump","move_down")
	if direction.x != 0 && sprite_animation.animation != "jump" && not animation_lock:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Attack Logic
	if Input.is_action_pressed("primary_attack"):
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
		animation_lock = false
 
func attack():
	if($AnimatedSprite2D.flip_h):
		$AttackArea/AttackAreaLeft.disabled = false
	else:
		$AttackArea/AttackAreaRight.disabled = false
	sprite_animation.play("primary_attack")
	animation_lock = true
	
func jump():
	velocity.y = jump_velocity
	sprite_animation.play("jump")
	animation_lock = true

func update_animation():
	if not animation_lock:
		if direction.x != 0 && !attacking:
			sprite_animation.play("run")
			sprite_animation.flip_h = velocity.x < 0
		else:
			sprite_animation.play("idle")
func _on_body_entered(body):
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


