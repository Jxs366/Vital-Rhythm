extends Sprite2D

# @export var move_speed: float = 4.5
@export var move_speed: float = 700.0

var init_x_pos: float = 663.0
var init_y_pos: float = -242.0

var has_passed: bool = false
var pass_threshold = -356.0

func _init() -> void:
	set_process(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(-move_speed * delta, 0)
	
	#Descubre cuanto tiempo tarda el corazon en llegar al lugar critico
	if position.x < pass_threshold - 110 and not $Timer.is_stopped():
		# print($Timer.wait_time - $Timer.time_left)
		$Timer.stop()
		has_passed = true

func Setup():
	global_position = Vector2(init_x_pos, init_y_pos)
	set_process(true)


func _on_destroy_timer_timeout() -> void:
	queue_free()
