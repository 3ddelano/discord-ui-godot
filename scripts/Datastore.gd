extends Node

signal maximized(value)
signal window_position(value)
signal window_size(value)
signal users_list_visible(value)

var _default_state = {
	"maximized": false,
	"window_position": Vector2(0, 0),
	"window_size": Vector2(1174, 626),
	"users_list_visible": true
}

var state = {}

func update_state(p_state: Dictionary = {}):
	p_state = merge(state, p_state)

	if p_state.maximized != state.maximized:
		emit_signal("maximized", p_state.maximized)

	if p_state.window_position != state.window_position:
		emit_signal("window_position", p_state.window_position)

	if p_state.window_size != state.window_size:
		emit_signal("window_size", p_state.window_size)

	if p_state.users_list_visible != state.users_list_visible:
		emit_signal("users_list_visible", p_state.users_list_visible)

	state = p_state
	_save_state()

var SAVE_LOCATION = "user://app_state.save"

func _ready() -> void:
	state = merge(_default_state, _load_state())
	print("Loaded App State: ", state)

	# Emit all the singals once here
	emit_signal("maximized", state.maximized)

func _save_state():
	var file = File.new()
	file.open(SAVE_LOCATION, File.WRITE)
	#print("Saved App State")
	file.store_var(state)
	file.close()

func _load_state():
	var file = File.new()
	file.open(SAVE_LOCATION, File.READ)
	var object = file.get_var()
	file.close()
	if object:
		return object
	return _default_state.duplicate()

func merge(a: Dictionary, b: Dictionary) -> Dictionary:
	var merged = a.duplicate()
	for key in a.keys():
		if b.has(key):
			merged[key] = b[key]
	return merged
