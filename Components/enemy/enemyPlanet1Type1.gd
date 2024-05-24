extends CharacterBody2D

@export var starting_move_direction : Vector2 = Vector2.LEFT

@onready var enemy_animation : AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dead = false 

var enemySpeed = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	var direction : Vector2 = starting_move_direction
	if direction && not dead: 
		velocity.x = direction.x * enemySpeed
		enemy_animation.play("walk")
	else:
		velocity.x =  move_toward(velocity.x, 0, enemySpeed)
		
		
	move_and_slide()

