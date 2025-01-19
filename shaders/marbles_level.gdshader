shader_type canvas_item;

uniform vec4 base_color: source_color;
uniform float speed: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform float dist: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform sampler2D noise: repeat_enable, filter_linear;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 col = base_color;
	col.r = sin(TIME * speed + UV.x * 2.0) - 0.5;
	col.g = sin(TIME * speed + UV.y * dist) - 0.8 + texture(noise, vec2(TIME * speed + UV.y * dist)).r;
	//col.r = 0.5;
	COLOR = col;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
