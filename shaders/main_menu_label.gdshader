shader_type canvas_item;

uniform float speed: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float dist: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform vec4 color_1 = vec4(1, 0, 0, 0);
uniform vec4 color_2 = vec4(0, 1, 0, 0);
uniform vec4 base_color: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	if (COLOR.a > 0.0) {
		vec4 col = base_color;
		col += color_1 * sin(TIME * speed + UV.x * dist);
		col += color_2 * sin(TIME * speed + UV.y * dist);
		COLOR = col;
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
