extends HBoxContainer

onready var bulles : Array = [get_node("bulle 1/AnimationPlayer"),get_node("bulle 2/AnimationPlayer")]

# Called when the node enters the scene tree for the first time.
func _ready():
	bulles[0].play("cache")
	bulles[1].play("cache")

	
func premiere_bulle(symbole):
	bulles[0].get_node("../icone").texture = symbole
	bulles[0].play("visible")
	bulles[1].play("emplacement")


func deuxieme_bulle(symbole):
	bulles[1].get_node("../icone").texture = symbole
	bulles[1].play("visible")


func rate():
	bulles[0].play("tombe")
	bulles[1].play("tombe")


func reussi():
	bulles[0].play("reussi")
	bulles[1].play("reussi")