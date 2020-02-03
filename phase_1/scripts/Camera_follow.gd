extends Camera2D

onready var target = get_node("../player")
export var decalage = Vector2(0,-400)

var changeZoom = false
var nextZoom
var tZoom 
var vitesseZoom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if changeZoom :
		tZoom += delta*vitesseZoom/100
		zoom = zoom.linear_interpolate(nextZoom,tZoom)
		if  abs(zoom.x-nextZoom.x) <= 0.002 :
			changeZoom = false
	
	global_position = target.global_position+decalage



func change_zoom(var newZoom, newVitesseZoom = 10):
	tZoom = 0.0
	vitesseZoom = newVitesseZoom
	changeZoom = true
	nextZoom = Vector2(newZoom,newZoom)