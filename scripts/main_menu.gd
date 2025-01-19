extends CanvasLayer

var game_scene = preload("res://scenes/level.tscn")
var marbles_scene = preload("res://scenes/marbles/marbles_level.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(game_scene)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_marbles_button_pressed():
	get_tree().change_scene_to_packed(marbles_scene)
