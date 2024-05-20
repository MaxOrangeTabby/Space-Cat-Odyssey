extends Node

var score
var enemy_scene = preload("res://Components/enemy/enemy_planet_1_type_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$EnemyTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_hit():
	pass # Replace with function body.


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()  

	var enemy_spawn_location = $EnemyPath/EnemySpawnLoc
	enemy.position = enemy_spawn_location.global_position
	
	add_child(enemy)


func _on_start_timer_timeout():
	$MobTimer.start()
