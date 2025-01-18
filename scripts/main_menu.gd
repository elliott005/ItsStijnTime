extends CanvasLayer

var game_scene = preload("res://scenes/level.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_quit_button_pressed():
	get_tree().quit()
