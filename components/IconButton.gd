tool
extends MarginContainer

export (Texture) var icon_texture = preload("res://assets/icons/minus.svg") setget set_icon_texture
export (Color) var icon_color_hover = Color() setget set_icon_color_hover
export (Color) var bg_color_hover = Color() setget set_bg_color_hover

func set_icon_texture(p_texture: Texture) -> void:
	$MC/Icon.texture = p_texture
	icon_texture = p_texture

func set_icon_color_hover(p_color: Color) -> void:
	icon_color_hover = p_color

func set_bg_color_hover(p_color) -> void:
	bg_color_hover = p_color
	var hover_stylebox = StyleBoxFlat.new()
	hover_stylebox.bg_color = bg_color_hover
	if Engine.is_editor_hint():
		$Button.add_stylebox_override("hover", hover_stylebox)

onready var _icon = $MC/Icon as TextureRect
onready var icon_color_normal = _icon.get_self_modulate()
onready var _button = $Button as Button

func _ready() -> void:
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	_button.connect("mouse_exited", self, "_on_mouse_exited")

	var hover_stylebox = StyleBoxFlat.new()
	hover_stylebox.bg_color = bg_color_hover
	_button.add_stylebox_override("hover", hover_stylebox)

func _on_mouse_entered():
	_icon.set_self_modulate(icon_color_hover)

func _on_mouse_exited():
	_icon.set_self_modulate(icon_color_normal)

func get_button() -> Button:
	return $Button as Button
