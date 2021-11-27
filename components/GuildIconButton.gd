extends Button

var model: GuildModel
var radius_normal = 0.5
var radius_hover = 0.55
var cur_radius = 0.5
var weight = 0.35

export (NodePath) var _icon_path
onready var _icon = get_node(_icon_path) as TextureRect

func _ready() -> void:
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	_icon.material.set_shader_param("radius", radius_normal)
	set_process(false)

func _on_mouse_entered() -> void:
	set_process(true)
	Signals.show_guild_hover_indicator(rect_global_position + Vector2(0, rect_size.y / 2))

func _on_mouse_exited() -> void:
	Signals.hide_guild_hover_indicator()

func _process(_delta: float) -> void:
	if is_hovered():
		#cur_radius = _icon.material.get_shader_param("radius")
		cur_radius = lerp(cur_radius, radius_hover, weight)
		_icon.material.set_shader_param("radius", cur_radius)
	else:
		#cur_radius = _icon.material.get_shader_param("radius")
		cur_radius = lerp(cur_radius, radius_normal, weight)
		_icon.material.set_shader_param("radius", cur_radius)

		if is_equal_approx(cur_radius, radius_normal):
			set_process(false)

func set_icon(p_texture: Texture):
	$Icon.texture = p_texture

func from_model(p_model: GuildModel):
	model = p_model
	$Icon.texture = model.icon
