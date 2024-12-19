extends Node2D

var jugador1 = 0
var jugador2 = 0
var tiempo_total = 20 
var tiempo_restante = tiempo_total

var bolas = {
	"Porti": preload("res://bolas/porti.png"),
	"Josep": preload("res://bolas/josep.png"),
	"Vini": preload("res://bolas/Vini.png"),
	"Pedrito": preload("res://bolas/Pedrito.png"),
	"Quero": preload("res://bolas/quero.png"),
}
onready var menu_pausa = $MenuPausa
onready var temporizador_partido = Timer.new()
func _ready():
	var Bola = get_node("/root/World/Ball/ColisionBola/Bola")
	Bola.texture = load(Globals.bola_seleccionada)
	$estadio.texture = load(Globals.estadio)
	
	$GolTimer.connect("timeout", self, "_on_GolTimer_timeout")
	
	add_child(temporizador_partido)
	temporizador_partido.wait_time = 1
	temporizador_partido.autostart = true
	temporizador_partido.one_shot = false
	temporizador_partido.connect("timeout", self, "_actualizar_tiempo")
	temporizador_partido.start()

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().get_nodes_in_group("menu")[0].visible = true
		get_tree().paused = true;
		
func _actualizar_tiempo():
	tiempo_restante -= 1
	_actualizar_ui()
	if tiempo_restante <= 0:
		_fin_partido()
			
func _on_Area2DDerecha_body_entered(body):
	if body.is_in_group("Ball"):
		jugador1 += 1


		reiniciarNivel()

func _on_Area2DIzquierda_body_entered(body):
	if body.is_in_group("Ball"):
		jugador2 += 1


		reiniciarNivel()
func _actualizar_ui():
	$ScoreTextoDerecha.text = str(jugador2)
	$ScoreTextoIzquierda.text = str(jugador1)
	

	var minutos = int(tiempo_restante / 60)
	var segundos = tiempo_restante % 60
	$Timer.text = str(minutos).pad_zeros(2) + ":" + str(segundos).pad_zeros(2)

func _fin_partido():
	temporizador_partido.stop()
	get_tree().get_nodes_in_group("menu")[0].visible = true
	get_tree().paused = true;
	if jugador1 > jugador2:
		print("¡Jugador 1 gana el partido!")
		$resultado.text = "¡Jugador 1 gana!"
	elif jugador2 > jugador1:
		print("¡Jugador 2 gana el partido!")
		$resultado.text = " ¡Jugador 2 gana!"
	else:
		print("¡Empate!")
		$resultado.text = "¡Empate!"
	$resultado.visible = true
	$MenuPausa/Reanudar.visible = false


func alternar_pausa():
	if get_tree().paused:
		get_tree().paused = false
		menu_pausa.visible = false 
	else:
		get_tree().paused = true 
		menu_pausa.visible = true 
		
func reanudar_partido():

	get_tree().paused = false 
	$MenuPausa.visible = false 


func reiniciarNivel():
	$ScoreTextoDerecha.text = str(jugador2)
	$ScoreTextoIzquierda.text = str(jugador1)
	$Ball.reset = true
	$resultado.visible = false

func reiniciarPartida():
	$MenuPausa/Reanudar.visible = true
	$ScoreTextoDerecha.text = str(0)
	$ScoreTextoIzquierda.text = str(0)
	jugador1 = 0
	jugador2 = 0
	
	$Ball.reset = true
	$resultado.visible = false
	
	tiempo_restante = tiempo_total
	temporizador_partido.wait_time = 1
	temporizador_partido.autostart = true
	temporizador_partido.one_shot = false
	temporizador_partido.connect("timeout", self, "_actualizar_tiempo")
	temporizador_partido.start()

func _on_Reanudar_pressed():
	reanudar_partido()


func _on_Salir_pressed():
	get_tree().quit()


func _on_Reiniciar_pressed():
	reiniciarPartida()
	reanudar_partido()


func _on_skins_pressed():
	$MenuPausa.visible = false;
	get_tree().change_scene("res://escenas/SeleccionarBola.tscn")
	
