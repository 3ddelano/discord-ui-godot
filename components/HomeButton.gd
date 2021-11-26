extends PanelContainer

var radius_normal = 26
var radius_hover = 17
var color_normal = Color("36393f")
var color_hover = Color("5865f2")
var icon_color_normal = Color("#dcddde")
var icon_color_hover = Color("#ffffff")
var weight = 0.35

onready var _button = $Button
onready var _icon = $MC/DiscordIcon
onready var stylebox = get_stylebox("panel", "PanelContainer") as StyleBoxFlat

func _ready() -> void:
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	_button.connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	Signals.show_guild_hover_indicator(rect_global_position + Vector2(0, rect_size.y / 2))

func _on_mouse_exited() -> void:
	Signals.hide_guild_hover_indicator()

func _process(delta: float) -> void:
	var new_radius
	var new_color
	if _button.is_hovered():
		new_radius = lerp(stylebox.get_corner_radius(0), radius_hover, weight)
		new_color = lerp(stylebox.bg_color, color_hover, weight)
		_icon.self_modulate = lerp(_icon.self_modulate, icon_color_hover, weight)
		#_hover_indicator.rect_scale = lerp(_hover_indicator.rect_scale, Vector2(1,1), weight)
	else:
		new_radius = lerp(stylebox.get_corner_radius(0), radius_normal, weight)
		new_color = lerp(stylebox.bg_color, color_normal, weight)
		_icon.self_modulate = lerp(_icon.self_modulate, icon_color_normal, weight)
		#_hover_indicator.rect_scale = lerp(_hover_indicator.rect_scale, Vector2(0,0), weight)

	stylebox.set_corner_radius_all(new_radius)
	stylebox.set_bg_color(new_color)
