extends KinematicBody2D


var velocidad = 300;
var direccion = Vector2.ZERO

func _physics_process(delta:float) -> void:
	direccion.y=Input.get_action_strength("player2down")-Input.get_action_strength("player2up")
	move_and_slide(direccion*velocidad)
