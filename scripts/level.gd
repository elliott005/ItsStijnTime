extends Node2D

@onready var mods_container = %ModsContainer
@onready var lost_container = %LostContainer
@onready var viewers = $Viewers
@onready var paddle = $Paddle
@onready var viewer_count_label = %ViewerCountLabel
@onready var won_container = $CanvasLayer/WonContainer

signal took_hit

@export var mods = [
	"Potato",
	"Finch"
]

var viewer_count = 0

var viewer_scene = preload("res://scenes/viewer.tscn")

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
			viewer.queue_free()
			viewer_count += 1
			viewer_count_label.text = str(viewer_count) + " viewers"
	if not viewers.get_child_count():
		get_tree().paused = true
		won_container.show()

func _on_took_hit():
	if mods.size():
		mods.pop_front()
		mods_container.remove_child(mods_container.get_child(0))
	else:
		get_tree().paused = true
		lost_container.show()


func _on_try_again_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()
