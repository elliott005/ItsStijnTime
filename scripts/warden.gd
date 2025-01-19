extends Node2D


const width = 130
const height = 40

var velocity = 0.0
var max_speed = 200.0
var acceleration = 300.0

func _process(delta):
	velocity = move_toward(velocity, max_speed, acceleration * delta)
	position.y += velocity * delta
	var screen_size = get_viewport().content_scale_size
	if position.y > screen_size.y:
		queue_free()
