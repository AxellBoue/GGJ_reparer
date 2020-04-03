extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout",self, "cache")
	$Timer.wait_time = 3

func affiche(image):
	if visible == false:
		texture = image
		visible = true
		$Timer.start()

func cache():
	visible=false