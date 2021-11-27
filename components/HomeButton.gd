extends PanelContainer

var radius_normal = 26
var cur_radius = 26
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

	stylebox.set_corner_radius_all(radius_normal)
	stylebox.set_bg_color(color_normal)

	get_parent().set_meta("tooltip_text", "Home")
	Signals.register_tooltip(get_parent(), "RIGHT")

func _on_mouse_entered():
	Signals.show_guild_hover_indicator(rect_global_position + Vector2(0, rect_size.y / 2))
	set_process(true)

func _on_mouse_exited() -> void:
	Signals.hide_guild_hover_indicator()
	yield(get_tree().create_timer(2.0), "timeout")

func _process(_delta: float) -> void:
	var new_color
	if _button.is_hovered():
		cur_radius = lerp(cur_radius, radius_hover, weight)
		new_color = lerp(stylebox.bg_color, color_hover, weight)
		_icon.self_modulate = lerp(_icon.self_modulate, icon_color_hover, weight)
	else:
		cur_radius = lerp(cur_radius, radius_normal, weight)
		new_color = lerp(stylebox.bg_color, color_normal, weight)
		_icon.self_modulate = lerp(_icon.self_modulate, icon_color_normal, weight)
		if is_equal_approx(cur_radius, radius_normal):
			set_process(false)

	stylebox.set_corner_radius_all(cur_radius)
	stylebox.set_bg_color(new_color)
