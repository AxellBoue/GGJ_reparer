extends Camera2D

onready var target = get_node("../player")
export var decalage = Vector2(0,-400)

var changeZoom = false
var nextZoom
var tZoom 
var vitesseZoom

var change_target = false
var zoom_depart 

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("../player")
	if player.get("zoom_normal") != null:
		zoom_depart = player.zoom_normal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if changeZoom :
		tZoom += delta*vitesseZoom/100
		zoom = zoom.linear_interpolate(nextZoom,tZoom)
		if  abs(zoom.x-nextZoom.x) <= 0.002 :
			changeZoom = false
	
	if !change_target:
		global_position = target.global_position+decalage



func change_zoom(var newZoom, newVitesseZoom = 10):
	if !change_target:
		tZoom = 0.0
		vitesseZoom = newVitesseZoom
		changeZoom = true
		nextZoom = Vector2(newZoom,newZoom)
	

func change_target(new_target):
	change_target = true
	changeZoom = false
	zoom = Vector2(zoom_depart,zoom_depart)
	global_position = new_target.global_position

func stop_change_target():
	change_target = false

	