#https://gist.github.com/MattUV/469ad2be96961c0afe8dfc1bf0932f76
class_name ExpandableTextEdit
extends TextEdit

export var expand = true
export var max_lines = 100000

var scroll_bar

onready var font = get_font("font")
var line_spacing
var line_height
var line_count = -1

func _ready():
	scroll_bar = _get_vscroll_bar()
	line_spacing = _get_line_spacing()
	line_height = font.get_height() + line_spacing
	line_count = _get_real_line_count()
	_update_height(line_count)

	connect("text_changed", self, "_text_changed")

func _get_line_spacing():
	var spacing = 4
	if get_constant("linespacing") != null:
		spacing  = get_constant("line_spacing")

	return spacing

func _get_real_line_count():
	var count = get_line_count()
	var lines_to_add = 0
	var scroll_size = scroll_bar.rect_size.x

	# Loop over every actual line in the TextEdit
	for i in count:
		var line = get_line(i) # Get the string of the line
		var width = font.get_string_size(line).x
		if width > rect_size.x - scroll_size:
			lines_to_add += int(width / (rect_size.x - scroll_size))

	return count + lines_to_add

func _get_vscroll_bar():
	for c in get_children():
		if c is VScrollBar:
			return c

func _update_height(count):
	if !expand:
		return

	var lines_to_show = count
	if lines_to_show > max_lines:
		lines_to_show = max_lines

	rect_min_size.y = lines_to_show * (line_height + line_spacing * 1.45)
	rect_size.y = rect_min_size.y
	update()

func _text_changed():
	_on_text_changed(false)

func _on_text_changed(force = false):
	var new_line_count = _get_real_line_count()
	if force or line_count != new_line_count:
		line_count = new_line_count
		_update_height(new_line_count)
