extends Node2D

@onready var label = $Label

@export var label_rotation_speed = 180
@export var label_scale_speed = 2.0
@export var label_text = ""

var time = 0.0

func _ready():
	label_rotation_speed = deg_to_rad(label_rotation_speed)
	label.text = label_text


func _process(delta):
	time += delta
	if time > 360.0:
		time -= 360.0
	rotation += delta * label_rotation_speed
	scale = Vector2.ONE * sin(time * label_scale_speed)
