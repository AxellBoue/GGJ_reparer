extends Node2D

export (Resource) var amandine
export (Resource) var franck
export (Resource) var fred
export (Resource) var karl
export (Resource) var louise
export (Resource) var rokhaya
var images_bulles = []
var bulles = []


var rand = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	images_bulles = [amandine,franck,fred,karl,louise,rokhaya]
	bulles = $bulles.get_children()
	$Timer.connect("timeout",self,"affiche_bulle")
	$Timer.start()
	rand.randomize()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func affiche_bulle():
	var i_bulles = rand.randi_range(0,bulles.size()-1)
	var i_images = rand.randi_range(0,images_bulles.size()-1)
	bulles[i_bulles].affiche(images_bulles[i_images])