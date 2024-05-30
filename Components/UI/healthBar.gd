extends ProgressBar

@onready var player =  $"../../Player"

func _ready():
	player.healthChanged.connect(update)
	update()
	
func update():
	value = value / 2
	print("update")

