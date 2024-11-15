extends Node2D

var seleccionado = 0;
var bolas = {
	"Porti": preload("res://bolas/porti.png"),
	"Josep": preload("res://bolas/josep.png"),
	"Vini": preload("res://bolas/Vini.png"),
	"Pedrito": preload("res://bolas/Pedrito.png"),
	
}

func cambiar_imagen_bola(bola):
	var bolaSelect = get_node("/root/Bolas/bolaSelect")
	
	if bola in bolas:
		bolaSelect.texture = bolas[bola]
		Globals.bola_seleccionada = bola
		
	else:
		print("No se encontró la imagen para", bolas)
		
func _on_Porti_pressed():
	cambiar_imagen_bola("Porti")
	seleccionado = 1;


func _on_Josep_pressed():
	cambiar_imagen_bola("Josep")
	seleccionado = 1;


func _on_Vini_pressed():
	cambiar_imagen_bola("Vini")
	seleccionado = 1;


func _on_Pedrito_pressed():
	cambiar_imagen_bola("Pedrito")
	seleccionado = 1;
		

func _on_Go_pressed():
	
	get_tree().change_scene("res://World.tscn")
	
