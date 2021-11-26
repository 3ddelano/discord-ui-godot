extends Button

var radius_normal = 0.5
var radius_hover = 0.55
var weight = 0.35

export (NodePath) var _icon_path
onready var _icon = get_node(_icon_path) as TextureRect

func _ready() -> void:
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")


func _on_mouse_entered() -> void:
	Signals.show_guild_hover_indicator(rect_global_position + Vector2(0, rect_size.y / 2))

func _on_mouse_exited() -> void:
	Signals.hide_guild_hover_indicator()

func _process(_delta: float) -> void:
	if is_hovered():
		var cur_radius = _icon.material.get_shader_param("radius")
		_icon.material.set_shader_param("radius", lerp(cur_radius, radius_hover, weight))
	else:
		var cur_radius = _icon.material.get_shader_param("radius")
		_icon.material.set_shader_param("radius", lerp(cur_radius, radius_normal, weight))

func set_icon(p_texture: Texture):
	$Icon.texture = p_texture
