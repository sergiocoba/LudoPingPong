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
onready var menu_pausa = $MenuPausa

func _ready():
  # Asegúrate de que muestra algo como: "res://path/to/image.png"
	var Bola = get_node("/root/World/Ball/ColisionBola/Bola")
	Bola.texture = load(Globals.bola_seleccionada)
	$estadio.texture = load(Globals.estadio)


func _physics_process(_delta):
	# Detectar si se presiona la tecla de pausa
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().get_nodes_in_group("menu")[0].visible = true
		get_tree().paused = true;
		
func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Ball"):
		jugador1 += 1


		reiniciarNivel()

func _on_Area2DIzquierda_body_entered(body):
	if body.is_in_group("Ball"):
		jugador2 += 1


		reiniciarNivel()

func alternar_pausa():
	if get_tree().paused:
		get_tree().paused = false # Reanuda el juego
		menu_pausa.visible = false # Oculta el menú de pausa
	else:
		get_tree().paused = true # Pausa el juego
		menu_pausa.visible = true # Muestra el menú de pausa
		
func reanudar_partido():
	get_tree().paused = false # Reanuda el juego
	$MenuPausa.visible = false # Oculta el menú de pausa


func reiniciarNivel():
	# Actualizar el marcador
	$ScoreTextoDerecha.text = str(jugador2)
	$ScoreTextoIzquierda.text = str(jugador1)
	$Ball.reset = true

	# Generar un color aleatorio
	var random_color = Color(randi() % 256 / 255.0, randi() % 256 / 255.0, randi() % 256 / 255.0)

	# Aplicar el color al fondo
	self.modulate = random_color  # Cambia el color del nodo Node2D, que afecta a su fondo

func reiniciarPartida():
	$ScoreTextoDerecha.text = str(0)
	$ScoreTextoIzquierda.text = str(0)
	self.modulate = 255255255
	$Ball.reset = true

func _on_Reanudar_pressed():
	reanudar_partido()


func _on_Salir_pressed():
	get_tree().quit()


func _on_Reiniciar_pressed():
	reiniciarPartida()
	reanudar_partido()
