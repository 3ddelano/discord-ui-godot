extends ExpandableTextEdit

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			var key_name = OS.get_scancode_string(event.get_scancode_with_modifiers())
			if key_name == "Enter" or key_name == "Kp Enter":
				get_tree().set_input_as_handled()
				if text.length() != 0:
					Signals.add_message({
						"content": text,
						"author_id": Cache.me_user.model.id,
						"timestamp": "Today at " + Utils.get_cur_time_string()
					})
					text = ""
					emit_signal("text_changed")
