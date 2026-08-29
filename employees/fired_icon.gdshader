shader_type canvas_item;
render_mode unshaded;
void fragment() {
	if (COLOR.b > 0.8)
		COLOR.a = 0.0;
	COLOR.r += 0.2;
}
