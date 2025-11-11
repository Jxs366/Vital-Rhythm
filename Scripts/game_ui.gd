extends Control

var health = 100

@onready var health_bar: ProgressBar = %HealthBar
   
const LOW_HEALTH_THRESHOLD = 40
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.DecrementHealth.connect(DecrementHealth)
	health_bar.value = health

func DecrementHealth(decr: int):
	health -= decr
	health = max(0, health)
	
	health_bar.value = health
	
	#if health <= 0:
		#print("Game Over")
 
