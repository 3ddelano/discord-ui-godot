tool
extends MarginContainer

export (Texture) var icon_texture = preload("res://assets/icons/minus.svg") setget set_icon_texture

var scale_normal = 0.8
var scale_hover = 1.0
var cur_scale = 0.8

var saturation_normal = 0.0
var saturation_hover = 1.0
var cur_saturation =  0.0

var weight = 0.35

func set_icon_texture(p_texture: Texture) -> void:
	icon_texture = p_texture
	if Engine.is_editor_hint():
		$MC/Icon.texture = icon_texture


onready var _icon = $MC/Icon as TextureRect
onready var icon_color_normal = _icon.get_self_modulate()
onready var _button = $Button as Button

func _ready() -> void:
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	rect_scale = Vector2(scale_normal, scale_normal)
	set_process(false)

func _on_mouse_entered():
	set_process(true)

func get_button() -> Button:
	return $Button as Button

func _process(_delta: float) -> void:
	if $Button.is_hovered():
		cur_scale = lerp(cur_scale, scale_hover, weight)
		cur_saturation = lerp(cur_saturation, saturation_hover, weight)
	else:
		cur_scale = lerp(cur_scale, scale_normal, weight)
		cur_saturation = lerp(cur_saturation, saturation_normal, weight)
		if is_equal_approx(cur_scale, scale_normal):
			set_process(false)

	_icon.material.set_shader_param("scale", cur_scale)
	_icon.material.set_shader_param("saturation", cur_saturation)
