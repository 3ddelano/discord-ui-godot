extends MarginContainer
"""
bg_color: #373a40
title_bar_color: #202225
"""

onready var debug_label = $VB/MC/Overlays/PC/MC/Debug

func _ready() -> void:
	get_tree().get_root().set_transparent_background(true)
	Signals.emit_signal("app_ready")
	OS.window_position = Datastore.state.window_position
	OS.window_size = Datastore.state.window_size

func _process(_delta: float) -> void:
	Signals.debug.fps = Engine.get_frames_per_second()

	var keys = Signals.debug.keys()
	debug_label.text = ""
	for key in keys:
		debug_label.text += key.to_upper() + ": " + str(Signals.debug[key]) + "\n"
	debug_label.text = debug_label.text.rstrip("\n")
