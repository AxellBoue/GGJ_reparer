extends KinematicBody2D

export var vitesse = 200
var mouvement

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	mouvement = Vector2(0,0)
	if Input.is_action_pressed("haut"):
		mouvement.y -= 1
	if Input.is_action_pressed("bas"):
		mouvement.y += 1
	if Input.is_action_pressed("droite"):
		mouvement.x += 1
	if Input.is_action_pressed("gauche"):
		mouvement.x -= 1
	mouvement = mouvement.normalized()
	mouvement = move_and_slide(mouvement*vitesse)

