extends Node2D

@onready var label = $Label

const width = 192
const height = 64

var dir = 0.0
var acceleration = 10.0
var speed = 400.0

var touch_screen_input = 0

func _process(delta):
	var input = Input.get_axis("move_left", "move_right")
	if not input:
		input = touch_screen_input
	dir = move_toward(dir, input, acceleration * delta)
	position.x += dir * speed * delta
	var screen_size = get_viewport().content_scale_size
	if position.x < 0.0 or position.x > screen_size.x - width:
		position.x = clamp(position.x, 0.0, screen_size.x - width)
		dir = 0.0
	
	for ball in get_tree().get_nodes_in_group("Balls"):
		if Rect2(position, Vector2(width, height)).intersects(Rect2(ball.position, Vector2(ball.width, ball.height))):
			ball.position.y = position.y - ball.height
			ball.dir.y *= -1
			ball.dir.x += dir
			ball.dir = ball.dir.normalized()
			if ball.dir.y < 0.3:
				ball.dir.y -= 0.2
				ball.dir = ball.dir.normalized()

func play_as_ruben():
	label.text = "Ruben"
	speed = 700.0
