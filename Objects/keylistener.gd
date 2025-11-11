extends Sprite2D

@export var heart = preload("res://Objects/heart.tscn")
@export var key_name: String = ""
@onready var music_player = $"../MusicPlayer"

var heart_queue = []
const HEART_SPAWN_INTERVAL = 0.5042016806722689
var bad_press_threshold = 100
var next_beat_time: float = 0.0

func _ready() -> void:
	music_player.play()
	next_beat_time = HEART_SPAWN_INTERVAL
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
# La lógica de _process debe cambiar para encontrar el más cercano al hacer clic.
func _process(delta):
	
	# 1. Quitar los corazones que ya pasaron
#	while heart_queue.size() > 0 and heart_queue.front().has_passed:
#		var failed_heart = heart_queue.pop_front()
#		failed_heart.queue_free()
#		Signals.DecrementHealth.emit(20)

	if Input.is_action_just_pressed(key_name):
		
		if heart_queue.size() > 0:
			var nearest_heart = null
			var min_distance = INF # Usamos INF para la distancia mínima inicial
			var nearest_index = -1 # Para saber qué corazón eliminar de la cola
			
			# 2. Iterar a través de todos los corazones para encontrar el más cercano
			for i in range(heart_queue.size()):
				var current_heart = heart_queue[i]
				
				# *** CÁLCULO DE DISTANCIA CORREGIDO ***
				# Calcula la diferencia entre las coordenadas X, y luego toma el valor absoluto.
				var distance = abs(current_heart.global_position.x - current_heart.pass_threshold)
				
				# Si este corazón está más cerca que el mínimo actual
				if distance < min_distance:
					min_distance = distance
					nearest_heart = current_heart
					nearest_index = i
					
			# 3. Procesar el corazón más cercano (nearest_heart)
			if nearest_heart != null:
				
				var distance_from_pass = min_distance
				
				if distance_from_pass > bad_press_threshold:
					Signals.DecrementHealth.emit(20)
				  
				# 4. Eliminar el corazón del juego y de la cola
				nearest_heart.queue_free()
				heart_queue.remove_at(nearest_index) # Lo eliminamos por índice
				
	var current_music_time = music_player.get_playback_position()
	if current_music_time >= next_beat_time:
		CreateHeart()
		next_beat_time += HEART_SPAWN_INTERVAL

func CreateHeart():
	var hrt_inst = heart.instantiate()
	get_tree().get_root().call_deferred("add_child", hrt_inst)
	hrt_inst.Setup()
	
	heart_queue.push_back(hrt_inst)

#func _on_spawn_timer_timeout() -> void:
#	CreateHeart()
#	$SpawnTimer.start()
