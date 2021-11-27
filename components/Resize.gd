extends Control

export (bool) var left = false
export (bool) var right = false
export (bool) var top = false
export (bool) var bottom = false

var _is_dragging = false
var drag_start_pos = Vector2()
var original_window_position = Vector2()
var original_window_size = Vector2()

func _ready() -> void:
	connect("gui_input", self, "_on_gui_input")
	Datastore.connect("maximized", self, "_on_maximized")
	set_process(false)

func _on_gui_input(event: InputEvent):
	if not (event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		# return if its not a left mouse button press
		return

	_is_dragging = !_is_dragging
	if not _is_dragging:
		Datastore.update_state({
			"window_size": OS.window_size,
			"window_position": OS.window_position
		})
	else:
		set_process(true)
	drag_start_pos = get_local_mouse_position()
	original_window_position = OS.window_position
	original_window_size = OS.window_size

func _process(_delta: float) -> void:
	if not _is_dragging:
		set_process(false)
		return

	if top:
		OS.window_size.y = max(original_window_size.y + (original_window_position.y - OS.window_position.y), Constants.MIN_SIZE.y)
		OS.window_position.y = (OS.window_position + get_global_mouse_position() - drag_start_pos).y

	if bottom:
		OS.window_size.y = max(get_global_mouse_position().y - drag_start_pos.y, Constants.MIN_SIZE.y)

	if left:
		OS.window_size.x = max(original_window_size.x + (original_window_position.x - OS.window_position.x), Constants.MIN_SIZE.x)

		OS.window_position.x = (OS.window_position + get_global_mouse_position() - drag_start_pos).x

	if right:
		OS.window_size.x = max(get_global_mouse_position().x - drag_start_pos.x, Constants.MIN_SIZE.x)

func _on_maximized(maximized):
	if maximized:
		set_visible(false)
	else:
		set_visible(true)
