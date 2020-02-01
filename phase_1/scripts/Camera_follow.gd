extends Camera2D

onready var target = get_node("../player")
export var decalage = Vector2(0,-400)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = target.global_position+decalage
