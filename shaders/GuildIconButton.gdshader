shader_type canvas_item;
uniform float radius:hint_range(0.01,0.99) = 0.5;
const float strength = 0.012;

void fragment() {
	float dist = distance(vec2(0.5,0.5), UV.xy);
	COLOR = texture(TEXTURE, UV);
	COLOR.a = (1.0 - smoothstep(radius - strength, radius + strength, dist));
}