extends PanelContainer

var color_normal = Color("#8e9297")
var color_hover = Color("#dcddde")
var angle_open = 0.0
var angle_closed = -90.0

onready var _button = $Button
onready var _icon = $MC/HB/Icon
onready var _name = $MC/HB/Name
onready var _tween = $Tween

var channels = []
var is_open = true

func set_name(p_name: String) -> void:
	$MC/HB/Name.text = p_name

func _ready() -> void:
	_button.connect("mouse_entered", self, "_on_mouse_entered")
	_button.connect("mouse_exited", self, "_on_mouse_exited")
	_button.connect("pressed", self, "_on_button_pressed")

func _on_mouse_entered():
	_name.self_modulate = color_hover
	_icon.self_modulate = color_hover

func _on_mouse_exited():
	_name.self_modulate = color_normal
	_icon.self_modulate = color_normal

func _on_button_pressed():
	if is_open:
		# Animate the chevron to closed
		_tween.interpolate_property(_icon, "rect_rotation", _icon.rect_rotation, angle_closed, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		for node in channels:
			node.visible = false
	else:
		# Animate the chevron to open
		_tween.interpolate_property(_icon, "rect_rotation", _icon.rect_rotation, angle_open, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
		for node in channels:
			node.visible = true

	_tween.start()
	is_open = not is_open
