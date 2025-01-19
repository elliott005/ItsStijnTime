shader_type canvas_item;

uniform vec4 base_color: source_color;
uniform float x: hint_range(0.0, 1.0) = 0.5;
uniform float limit: hint_range(0.0, 1.0) = 0.2;
uniform float y: hint_range(0.0, 1.0) = 0.3;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 col = base_color;
	float a = x / distance(UV, vec2(0.5, 0.5));
	if (a > limit) {
		col.a = a - y;
	} else {
		col.a = 0.0;
	}
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
