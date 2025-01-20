extends Node2D

@onready var world = $World
@onready var camera_2d = $Camera2D
@onready var start_container = $CanvasLayer/StartContainer
@onready var player_1_text_edit = %Player1TextEdit
@onready var player_2_text_edit = %Player2TextEdit
@onready var marbles = $Marbles
@onready var player_1_label = %Player1Label
@onready var player_2_label = %Player2Label
@onready var end_center_container = $CanvasLayer/EndCenterContainer
@onready var winner_label = $CanvasLayer/EndCenterContainer/VBoxContainer/WinnerLabel
@onready var potato_cheers = $PotatoCheers

@export var world_color: Color

signal clicked_marble(marble)

var selected_marble = null

var marble_scene = preload("res://scenes/marbles/marble.tscn")

var zoom_speed = 0.2
var zoom_min = 0.1
var zoom_max = 5.0

var random_start_pos_max = Vector2(200, 100)

var num_ready = 0
var potato_playing = false

func _ready():
	end_center_container.hide()
	potato_cheers.hide()
	
	for child in world.get_children():
		for coll in child.get_children():
			var poly = Polygon2D.new()
			poly.polygon = coll.polygon
			poly.color = Color(randf(), randf(), randf(), 1)#world_color
			coll.add_child(poly)
	
	get_tree().paused = true
	
	clicked_marble.connect(on_marble_clicked)

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		camera_2d.zoom = camera_2d.zoom.move_toward(Vector2.ONE * zoom_max, zoom_speed)
	elif Input.is_action_just_pressed("zoom_out"):
		camera_2d.zoom = camera_2d.zoom.move_toward(Vector2.ONE * zoom_min, zoom_speed)
	
	if selected_marble != null:
		if Input.is_action_just_pressed("drag_camera"):
			selected_marble = null
		else:
			camera_2d.position = selected_marble.global_position

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("drag_camera"):
			camera_2d.position -= event.relative / camera_2d.zoom.x

func on_marble_clicked(marble):
	selected_marble = marble

func _on_ready_1_button_pressed():
	num_ready += 1
	var marble1 = marble_scene.instantiate()
	marble1.marble_name = player_1_text_edit.text
	marble1.position = Vector2(randi_range(0, random_start_pos_max.x), randi_range(0, random_start_pos_max.y))
	marbles.add_child(marble1)
	
	player_1_label.text += " READY"
	
	ready_marble(player_1_text_edit.text)


func _on_ready_2_button_pressed():
	num_ready += 1
	var marble2 = marble_scene.instantiate()
	marble2.marble_name = player_2_text_edit.text
	marble2.position = Vector2(randi_range(0, random_start_pos_max.x), randi_range(0, random_start_pos_max.y))
	marbles.add_child(marble2)
	
	player_2_label.text += " READY"
	
	ready_marble(player_2_text_edit.text)

func ready_marble(marble_name):
	if num_ready >= 2:
		get_tree().paused = false
		start_container.hide()
	if marble_name.to_lower() == "potato":
		potato_cheers.show()
		potato_playing = true


func _on_back_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_end_area_2d_body_entered(body):
	if not end_center_container.visible:
		end_center_container.show()
		if potato_playing and body.marble_name.to_lower() != "potato":
			winner_label.text = body.marble_name + " was disqualified! Winner: Potato"
		else:
			winner_label.text += body.marble_name


func _on_try_again_button_pressed():
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
