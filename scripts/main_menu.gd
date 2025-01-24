extends CanvasLayer

@onready var title_label = $TitleLabel
@onready var second_title_label = $SecondTitleLabel

var game_scene = preload("res://scenes/level.tscn")
var marbles_scene = preload("res://scenes/marbles/marbles_level.tscn")

var typed = ""
var trigger = "RUBEN"
var change_time = 1.0
var change_trans_type: Tween.TransitionType = Tween.TRANS_SINE

func _ready():
	Globals.r_clicked = false

func _unhandled_input(event):
	if event is InputEventKey:
		if not event.is_echo() and event.pressed:
			var key_str = OS.get_keycode_string(event.keycode)
			if typed or key_str == "R":
				typed += key_str
				if typed == trigger:
					var label_tween = get_tree().create_tween()
					label_tween.parallel()
					label_tween.tween_property(title_label, "position", Vector2(-600, title_label.position.y), change_time).set_trans(change_trans_type)
					label_tween.tween_property(second_title_label, "position", Vector2(256, second_title_label.position.y), change_time).set_trans(change_trans_type)

func _on_play_button_pressed():
	if Input.is_action_pressed("r"):
		Globals.r_clicked = true
	get_tree().change_scene_to_packed(game_scene)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_marbles_button_pressed():
	get_tree().change_scene_to_packed(marbles_scene)
