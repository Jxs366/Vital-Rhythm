extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_play_btn_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/game_level.tscn")


func _on_play_btn_2_pressed() -> void:
	pass # Replace with function body.
