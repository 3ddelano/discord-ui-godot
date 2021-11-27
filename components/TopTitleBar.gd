extends PanelContainer

"""
close_btn
- hover: ffffff
- bg_hover: ed4245
"""

export (NodePath) var _minimize_btn_path
export (NodePath) var _maximize_btn_path
export (NodePath) var _close_btn_path
onready var _minimize_btn = get_node(_minimize_btn_path).get_button() as Button
onready var _maximize_btn = get_node(_maximize_btn_path).get_button() as Button
onready var _close_btn = get_node(_close_btn_path).get_button() as Button

var _is_dragging = false
var _last_click_time = -1
var drag_start_pos = Vector2()
onready var original_size = Datastore.state.window_size
onready var original_position = Datastore.state.window_position

func _ready() -> void:
	Signals.connect("register_tooltip", get_parent().get_parent().get_node("ToolTips"), "_on_register_tooltip")
	if OS.get_name() == "HTML5":
		queue_free()
		return

	_minimize_btn.connect("pressed", self, "_on_minimize_btn_pressed")
	_maximize_btn.connect("pressed", self, "_on_maximize_btn_pressed")
	_close_btn.connect("pressed", self, "_on_close_btn_pressed")
	connect("gui_input", self, "_on_gui_input")

	if Datastore.state.maximized:
		_maximize(true)

func _on_minimize_btn_pressed():
	OS.set_window_minimized(true)

func _on_maximize_btn_pressed():
	_maximize()

func _on_close_btn_pressed():
	get_tree().quit()

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			var time_since_click = OS.get_ticks_msec() - _last_click_time
			_last_click_time = OS.get_ticks_msec()
			if time_since_click > 0 and time_since_click < 500:
				_maximize()
				return

		if event.pressed:
			_is_dragging = !_is_dragging
		else:
			_is_dragging = false
			Datastore.update_state({
				"window_position": OS.window_position
			})
		if _is_dragging:
			drag_start_pos = get_local_mouse_position()


	if _is_dragging:
		OS.set_window_position(OS.window_position + get_global_mouse_position() - drag_start_pos)
		if Datastore.state.maximized:
			_maximize()
			return

func _maximize(force = false):
	if Datastore.state.maximized and not force:
		OS.set_window_size(original_size)
		OS.set_window_position(original_position)
		Datastore.update_state({
			"window_size": original_size,
			"window_position": original_position,
			"maximized": false
		})
	else:
		original_size = OS.get_window_size()
		original_position = OS.get_window_position()
		var max_size = OS.get_screen_size()
		if OS.get_name() != "HTML5":
			# Account for the taskbar height
			max_size -= Vector2(0,60)

		OS.set_window_size(max_size)
		OS.set_window_position(Vector2(0,0))
		Datastore.update_state({
			"window_size": max_size,
			"window_position": Vector2(0,0),
			"maximized": true
		})
