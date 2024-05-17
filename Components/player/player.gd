extends CharacterBody2D
signal hit

const gravity = 35	

@export var speed = 500

var attacking = false	
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
		$AnimatedSprite2D.play()
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed
		$AnimatedSprite2D.play()
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -1250	
	if not is_on_floor():
		velocity.y = velocity.y + gravity

	move_and_slide()
	
	# Prevent offscreen movement
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0

	if Input.is_action_just_pressed("primary_attack") and not attacking:
		$AnimatedSprite2D.play("primary_attack")

func _on_body_entered(body):
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


