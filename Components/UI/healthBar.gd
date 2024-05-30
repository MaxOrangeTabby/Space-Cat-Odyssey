extends ProgressBar

@onready var player =  $"../../Player"

func _ready():
	player.healthChanged.connect(update)

	
func update(damage_taken):
	value = value - damage_taken
	print("update")

