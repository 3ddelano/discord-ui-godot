extends ExpandableTextEdit

var me_user

func _ready() -> void:
	Signals.connect("app_ready", self, "_on_app_ready")

func _on_app_ready() -> void:
	for user in Cache.users.values():
		if user.model.tag == "3ddelano#6033":
			me_user = user

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			var key_name = OS.get_scancode_string(event.get_scancode_with_modifiers())

			if key_name == "Enter":
				get_tree().set_input_as_handled()
				if text.length() != 0:
					Signals.add_message({
						"content": text,
						"author_id": me_user.model.id,
						"timestamp": "Today at " + Utils.get_cur_time_string()
					})
					text = ""
					emit_signal("text_changed")
