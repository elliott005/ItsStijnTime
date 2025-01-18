extends Node2D

@onready var mods_container = %ModsContainer
@onready var lost_container = %LostContainer
@onready var viewers = $Viewers
@onready var paddle = $Paddle
@onready var viewer_count_label = %ViewerCountLabel
@onready var won_container = $CanvasLayer/WonContainer
@onready var score_label = %ScoreLabel

signal took_hit

@export var mods = [
	"Potato",
	"Finch"
]

var viewer_count = 0

var viewer_scene = preload("res://scenes/viewer.tscn")

var mod_death_time = 0.7
var viewer_collect_time = 0.5

func _ready():
	viewer_count_label.text = "0 viewers"
	lost_container.hide()
	won_container.hide()
	for mod in mods:
		var mod_label = Label.new()
		mod_label.text = mod
		mods_container.add_child(mod_label)
	
	var screen_size = get_viewport().content_scale_size
	var spawn_area_size = Vector2(screen_size.x, screen_size.y / 2 - 100)
	
	for i in range(5):
		var viewer = viewer_scene.instantiate()
		viewer.position = Vector2(randi_range(0, spawn_area_size.x), randi_range(0, spawn_area_size.y))
		viewers.add_child(viewer)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	for viewer in viewers.get_children():
		if Rect2(paddle.position, Vector2(paddle.width, paddle.height)).intersects(Rect2(viewer.position, Vector2(viewer.width, viewer.height))):
			viewer_count += 1
			viewer_count_label.text = str(viewer_count) + " viewers"
			var viewer_label = Label.new()
			viewer_label.text = "viewer"
			viewer_label.position = viewer.position
			add_child(viewer_label)
			var tween = get_tree().create_tween()
			tween.set_parallel()
			tween.tween_property(viewer_label, "position", Vector2(0, 0), viewer_collect_time)
			tween.tween_property(viewer_label, "rotation", 2 * PI, viewer_collect_time)
			tween.tween_property(viewer_label, "scale", Vector2.ONE * 0.1, viewer_collect_time)
			tween.tween_callback(viewer_label.queue_free).set_delay(viewer_collect_time)
			viewer.queue_free()
	if not viewers.get_child_count():
		get_tree().paused = true
		score_label.text = "Score: " + str(viewer_count)
		won_container.show()

func _on_took_hit():
	if mods.size():
		mods_container.remove_child(mods_container.get_child(0))
		var screen_size = get_viewport().content_scale_size
		var mod_label = Label.new()
		mod_label.text = mods[0]
		mod_label.position = Vector2(0.0, screen_size.y - 100.0)
		add_child(mod_label)
		var tween = get_tree().create_tween()
		tween.set_parallel()
		tween.tween_property(mod_label, "position", screen_size / 2.0 - Vector2(100, 100), mod_death_time)
		tween.tween_property(mod_label, "rotation", 2 * PI, mod_death_time)
		tween.tween_property(mod_label, "scale", Vector2.ONE * 0.1, mod_death_time)
		tween.tween_callback(mod_label.queue_free).set_delay(mod_death_time)
		mods.pop_front()
	else:
		get_tree().paused = true
		lost_container.show()


func _on_try_again_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
