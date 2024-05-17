extends RigidBody2D

var enemySpeed = -5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += enemySpeed 


	
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
