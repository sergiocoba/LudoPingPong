extends Node2D

var jugador1 = 0
var jugador2 = 0



func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Ball"):
		jugador1 +=1;
		reiniciarNivel()
	pass # Replace with function body.


func _on_Area2DIzquierda_body_entered(body):
	if body.is_in_group("Ball"):
		jugador2 +=1;
		reiniciarNivel()
	pass # Replace with function body.

func reiniciarNivel():
	$ScoreTextoDerecha.text=str(jugador2)
	$ScoreTextoIzquierda.text=str(jugador1)
	$Ball.reset = true
	
