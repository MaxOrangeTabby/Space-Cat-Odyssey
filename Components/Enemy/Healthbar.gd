extends ProgressBar



func _ready():
	get_parent().damaged.connect(updateHealth)
	
	# Get initial health of enemy
	value = ($"../Damagable".hp)

func updateHealth(damage_taken):
	value -= damage_taken
