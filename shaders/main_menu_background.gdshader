shader_type canvas_item;

uniform float speed: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float dist: hint_range(0.0, 10.0, 0.1) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = COLOR;
	col.b = sin(TIME * speed + UV.x * dist) - 0.5;
	col.g = sin(TIME * speed + UV.y * dist) - 0.6;
	col.r = 0.4;
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
