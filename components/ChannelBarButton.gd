tool
extends MarginContainer

export (Texture) var _icon_texture = preload("res://assets/icons/bell.svg") setget _set_icon_texture
export (String) var _tooltip_text = "Test tooltip"
export (bool) var is_toggle = false setget set_is_toggle
export (bool) var toggle_state = false setget set_toggle_state

func _set_icon_texture(p_texture):
	_icon_texture = p_texture
	$MC/Icon.texture = p_texture

onready var _icon = $MC/Icon
onready var _button = $Button
onready var _self_modulate_normal = _icon.get_self_modulate()
onready var _self_modulate_hover = Color("#dcddde")
var ready = false

func _ready() -> void:
	_button.connect("pressed", self, "_on_button_pressed")
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	_button.connect("mouse_exited", self, "_on_mouse_exited")

	$Button.set_meta("tooltip_text", _tooltip_text)
	set_meta("tooltip_text", _tooltip_text)
	ready = true
	_update_self_modulate()

func set_is_toggle(p_is_toggle: bool) -> void:
	is_toggle = p_is_toggle
	_update_self_modulate()

func set_toggle_state(p_toggle_state: bool) -> void:
	toggle_state = p_toggle_state
	_update_self_modulate()

func _update_self_modulate():
	if is_toggle and ready:
		# Check if the toggle state is true, if yes then keep the hover color
		if toggle_state:
			$MC/Icon.set_self_modulate(_self_modulate_hover)
		else:
			$MC/Icon.set_self_modulate(_self_modulate_normal)

func _on_button_pressed():
	if is_toggle:
		toggle_state = !toggle_state

func _on_mouse_entered():
	_icon.set_self_modulate(_self_modulate_hover)

func _on_mouse_exited():
	if is_toggle:
		# Check if the toggle state is true, if yes then keep the hover color
		if !toggle_state:
			_icon.set_self_modulate(_self_modulate_normal)
	else:
		# For a normal button, we set the color back to normal
		_icon.set_self_modulate(_self_modulate_normal)

func get_button():
	return $Button
