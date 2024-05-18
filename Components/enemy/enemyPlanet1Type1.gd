extends RigidBody2D

var enemySpeed = -2.5
var dead = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += enemySpeed 

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_hitbox_area_area_entered(area):
	if area.is_in_group("Sword"):
		dead = true;
		$AnimatedSprite2D.play("death");

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		enemySpeed = 0;
		global_position.x = global_position.x;
		queue_free();
