extends AnimatableBody2D

@onready var node_2d = $Node2D

@export var rotation_speed = 200.0
@export var changing := false
@export var change_time = 1.0
@export var base_color: Color = Color(0.2, 1, 0.5)

var time = 0.0
var rotational_velocity = 0.0

func _ready():
	rotation_speed = deg_to_rad(rotation_speed)
	rotation_degrees = randi_range(0, 360)
	
	for child in node_2d.get_children():
		child.color = base_color

func _physics_process(delta):
	if changing:
		time += delta * change_time
		if time > 360.0:
			time -= 360.0
		rotational_velocity = sin(time) * rotation_speed
	else:
		rotational_velocity = rotation_speed
	rotation += delta * rotational_velocity
