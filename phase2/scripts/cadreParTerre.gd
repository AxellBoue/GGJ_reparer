extends Sprite

var emplacement_cocardes 
var nombre_cocardes = 6
var cocardes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var i = 1
	while i <= nombre_cocardes :
		cocardes.append(load("res://phase_1/images/cocardes/cocarde" + String(i) + ".png"))
		i += 1
	emplacement_cocardes = get_node("enplacement cocardes").get_children()
	var a = 0
	while singleton.cocardes.size() > a && singleton.cocardes[a] != 9:
		emplacement_cocardes[a].texture = cocardes[singleton.cocardes[a]]
		emplacement_cocardes[a].visible = true
		a += 1
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
