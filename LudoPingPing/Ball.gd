extends RigidBody2D


func _draw():
	draw_circle(Vector2(0,0),5,Color(1,1,1))

var velocidad = 500
var direccion = 1
var reset = false
var sonido_reproducido = false


func _ready():
	linear_velocity.x = velocidad*direccion

func _physics_process(delta:float):
	linear_velocity.x = velocidad*direccion


func _on_Ball_body_entered(body):
	if body.is_in_group("Player"):
		reproducir_sonido()
		print("entro")
		direccion*=-1
	else:
		$AudioStreamPlayer.stop();
		

func reproducir_sonido():
	if $AudioStreamPlayer.stream and not $AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.play();
			sonido_reproducido = true
			
		
func _physics_process_post(delta):
	# Restablecer la bandera cuando ya no haya colisiones con la bola
		sonido_reproducido = false
		
func _integrate_forces(state: Physics2DDirectBodyState):
	if reset:
		direccion*=-1
		linear_velocity = Vector2.ZERO
		state.angular_velocity = 0.0
		state.transform.origin = Vector2(612,300)
		reset = false
