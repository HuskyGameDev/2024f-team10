extends Control

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/interface_scenes/title_screen.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
