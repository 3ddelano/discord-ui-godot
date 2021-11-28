extends PanelContainer

var color_normal = Color("#8e9297")
var color_hover = Color("#dcddde")

onready var _button = $Button
onready var _icon = $MC/HB/Icon
onready var _name = $MC/HB/Name

func set_icon(p_texture: Texture)  -> void:
	$MC/HB/Icon.texture = p_texture

func set_name(p_name: String) -> void:
	$MC/HB/Name.text = p_name

func _ready() -> void:
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	_button.connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	_name.self_modulate = color_hover

func _on_mouse_exited():
	_name.self_modulate = color_normal
