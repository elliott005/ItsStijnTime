extends RigidBody2D

@onready var label = $Node2D/Label
@onready var node_2d = $Node2D
@onready var color_rect = $ColorRect

@export var marble_name: String

func _ready():
	label.text = marble_name
	color_rect.color = Color(randf(), randf(), randf(), 1)

func _process(delta):
	node_2d.rotation = -rotation


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			get_parent().get_parent().clicked_marble.emit(self)
