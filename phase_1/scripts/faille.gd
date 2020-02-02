extends Area2D

onready var shooter = get_node("/root/Node2D/phase 1 obligatoire/shoot")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"on_area_entered")
	connect("area_exited",self,"on_area_exited")


func on_area_entered(area):
	if area.name == "viseur":
		shooter.faille = self


func on_area_exited(area):
	if area.name == "viseur":
		shooter.faille = null
