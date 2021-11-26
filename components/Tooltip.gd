tool
extends Panel

export var _max_rect = Vector2(190, 100) setget _set_max_rect
export var _margin = Vector2(8, 8) setget _set_margin
export var _text = "Help" setget _set_text
onready var _tween = Tween.new()

func _ready() -> void:
	_calculate_label_size()
	_tween.connect("tween_all_completed", self, "queue_free")

func _set_max_rect(p_max_rect: Vector2) -> void:
	_max_rect = p_max_rect

func _set_margin(p_margin: Vector2) -> void:
	_margin = p_margin

func _set_text(p_text):
	_text = p_text
	if Engine.is_editor_hint():
		_calculate_label_size()

func _calculate_label_size():
	# Update the text of the label
	var label = $Label
	label.text = _text

	# Get the single-line and autowrapped text size
	var rect = get_font("font", "Label").get_string_size(_text)
	var wrap_rect = get_font("font", "Label").get_wordwrap_string_size(_text, _max_rect.x)
	label.set_size(Vector2(0, 0))
	if rect.x < wrap_rect.x:
		# Text can fit in one line
		label.set_size(rect)
		label.set_autowrap(false)
	else:
		# Text needs multiple lines
		label.set_autowrap(true)
		label.set_size(wrap_rect)

	label.set_position(_margin / 2)
	set_size(label.get_size() + _margin)
	rect_pivot_offset = rect_size / 2
	$Triangle.rect_position.x = (get_size().x - $Triangle.get_size().x * 0.8) / 2
	label.set_position(_margin / 2)

func set_text(text: String):
	_text = text
	_calculate_label_size()


# Animation
func hide_and_delete():
	$AnimationPlayer.play("hide")
