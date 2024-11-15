extends Node2D

var jugador1 = 0
var jugador2 = 0




	
var bolas = {
	"Porti": preload("res://bolas/porti.png"),
	"Josep": preload("res://bolas/josep.png"),
	"Vini": preload("res://bolas/Vini.png"),
	"Pedrito": preload("res://bolas/Pedrito.png"),
}

func _ready():
	var Bola = get_node("/root/World/Ball/ColisionBola/Bola")
	Bola.texture = bolas[Globals.bola_seleccionada]

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
	
