extends HBoxContainer

func _ready() -> void:
	Signals.connect("app_ready", self, "_on_app_ready")
	$UsersButton.get_button().connect("pressed", self, "_on_users_button_pressed")

	if Datastore.state.users_list_visible:
		$UsersButton.toggle_state = true
	else:
		$UsersButton.toggle_state = false

func _on_app_ready():
	for node in get_children():
		node = node as Node
		if node.has_meta("tooltip_text"):
			Signals.register_tooltip(node.get_node("Button"), "DOWN")

func _on_users_button_pressed():
	Datastore.update_state({
		"users_list_visible": !Datastore.state.users_list_visible
	})
