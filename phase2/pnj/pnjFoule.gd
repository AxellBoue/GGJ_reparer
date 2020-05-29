extends StaticBody2D

var t = 0
var temps_cache_bulle = 0.8
var parle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("bulle").visible :
		parle = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parle :
		t += delta
		if t >= temps_cache_bulle :
			t = 0
			cache_bulle()
		

func parle():
	parle = true
	$bulle.visible = true
	$AudioStreamPlayer2D.play()

func cache_bulle():
	parle = false
	$bulle.visible = false