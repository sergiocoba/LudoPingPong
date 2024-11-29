extends Node2D

var jugador1 = 0
var jugador2 = 0


var bolas = {
	"Porti": preload("res://bolas/porti.png"),
	"Josep": preload("res://bolas/josep.png"),
	"Vini": preload("res://bolas/Vini.png"),
	"Pedrito": preload("res://bolas/Pedrito.png"),
	"Quero": preload("res://bolas/quero.png"),
}

func _ready():
	var Bola = get_node("/root/World/Ball/ColisionBola/Bola")
	Bola.texture = bolas[Globals.bola_seleccionada]



func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Ball"):
		jugador1 += 1


		reiniciarNivel()

func _on_Area2DIzquierda_body_entered(body):
	if body.is_in_group("Ball"):
		jugador2 += 1


		reiniciarNivel()

func reiniciarNivel():
	# Actualizar el marcador
	$ScoreTextoDerecha.text = str(jugador2)
	$ScoreTextoIzquierda.text = str(jugador1)
	$Ball.reset = true

	# Generar un color aleatorio
	var random_color = Color(randi() % 256 / 255.0, randi() % 256 / 255.0, randi() % 256 / 255.0)

	# Aplicar el color al fondo
	self.modulate = random_color  # Cambia el color del nodo Node2D, que afecta a su fondo
