extends Node2D

const width = 130
const height = 40

var hit = false
var velocity = 0.0
var max_speed = 200.0
var acceleration = 300.0


func _process(delta):
	if hit:
		velocity = move_toward(velocity, max_speed, acceleration * delta)
		position.y += velocity * delta
		var screen_size = get_viewport().content_scale_size
		if position.y > screen_size.y:
			queue_free()
	else:
		for ball in get_tree().get_nodes_in_group("Balls"):
			if Rect2(position, Vector2(width, height)).intersects(Rect2(ball.position, Vector2(ball.width, ball.height))):
				ball.dir.y *= -1
				hit = true
