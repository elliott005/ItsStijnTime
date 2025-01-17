extends Node2D

const width = 64
const height = 48

var dir = Vector2(1, 0.5).normalized()
var speed = 300.0

func _process(delta):
	position += dir * speed * delta
	var screen_size = get_viewport().size
	if position.x < 0.0 or position.x > screen_size.x - width:
		dir.x *= -1
		position.x = clamp(position.x, 0.0, screen_size.x - width)
	if position.y < 0.0:
		position.y = 0.0
		dir.y *= -1
	if position.y > screen_size.y:
		position.y = 0.0
		get_parent().took_hit.emit()
