extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"on_area_entered")
	pass # Replace with function body.


func on_area_entered(area):
	if area.name == "viseur":
		print("faille")
