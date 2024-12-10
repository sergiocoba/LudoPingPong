extends Control

# Variables y nodos
var personajes_jugador1 = [
	"res://campos/CampoChampions.png", 
	"res://campos/CampoFutbol.png", 
	"res://campos/MesaPingPong.png", 
	"res://campos/PistaHockey.png", 
	"res://campos/PistaHockeyMovil.png"
]

var indice_jugador1 = 0

# Variables de estado
var listo_jugador1 = false

# Nodos principales
onready var vista_personaje_jugador1 = $PanelBola/VistaPersonajePlayer  # Asegúrate de que este nodo es un contenedor
onready var boton_anterior_jugador1 = $PanelBola/BotonAnterior
onready var boton_siguiente_jugador1 = $PanelBola/BotonSiguiente
onready var boton_confirmar_jugador1 = $PanelBola/BotonConfirmar


func _ready():
	# Conectar los botones para el jugador 1
	boton_anterior_jugador1.connect("pressed", self, "_mostrar_anterior_jugador1")
	boton_siguiente_jugador1.connect("pressed", self, "_mostrar_siguiente_jugador1")
	boton_confirmar_jugador1.connect("pressed", self, "_confirmar_seleccion_jugador1")
	
	# Mostrar los personajes iniciales
	_cargar_personaje_jugador1(indice_jugador1)

# Función para cargar el personaje del jugador 1
func _cargar_personaje_jugador1(indice):
	# Asegurarse de que el índice sea válido
	if indice < 0 or indice >= personajes_jugador1.size():
		print("Índice fuera de rango: %d" % indice)
		return
	
	# Limpiar cualquier contenido previo en la vista
	for child in vista_personaje_jugador1.get_children():
		vista_personaje_jugador1.remove_child(child)
		child.queue_free()
	
	# Cargar la textura del personaje
	var personaje_texture = load(personajes_jugador1[indice])
	if personaje_texture is Texture:
		# Crear un nuevo Sprite y asignar la textura
		var sprite = Sprite.new()
		sprite.texture = personaje_texture
		vista_personaje_jugador1.add_child(sprite)
	else:
		print("Error: El recurso no es del tipo Texture.")

# Función para mostrar el personaje anterior del jugador 1
func _mostrar_anterior_jugador1():
	if !listo_jugador1:  # Solo cambiar si el jugador no está listo
		indice_jugador1 -= 1
		if indice_jugador1 < 0:
			indice_jugador1 = personajes_jugador1.size() - 1
		_cargar_personaje_jugador1(indice_jugador1)

# Función para mostrar el personaje siguiente del jugador 1
func _mostrar_siguiente_jugador1():
	if !listo_jugador1:  # Solo cambiar si el jugador no está listo
		indice_jugador1 += 1
		if indice_jugador1 >= personajes_jugador1.size():
			indice_jugador1 = 0
		_cargar_personaje_jugador1(indice_jugador1)

# Función para confirmar la selección del jugador 1
func _confirmar_seleccion_jugador1():
	if listo_jugador1:
		# Si ya está listo, permitirle volver a elegir su personaje
		listo_jugador1 = false
		boton_confirmar_jugador1.text = "Confirmar"
		boton_anterior_jugador1.disabled = false
		boton_siguiente_jugador1.disabled = false
	else:
		# Si no está listo, confirmamos la selección
		listo_jugador1 = true

		boton_anterior_jugador1.disabled = true
		boton_siguiente_jugador1.disabled = true
		print("Personaje jugador 1 confirmado: %s" % personajes_jugador1[indice_jugador1])
		Globals.estadio = personajes_jugador1[indice_jugador1] 
		 # Guardar selección en GameData
		_verificar_listos()

func _verificar_listos():
	if listo_jugador1:
		print("Ambos jugadores están listos.")
		# Cambiar la escena
		get_tree().change_scene("res://escenas/World.tscn")
