extends ReferenceRect

export (PackedScene) var _tooltip_scene

var tooltips = []
var owners = {}

export (Vector2) var padding = Vector2(8, 8)

func _on_register_tooltip(node: Object, dir: String):
	assert(node is Control, "Expected " + node.name + " to be a Control")
	node.connect("mouse_entered", self, "_on_mouse_entered", [node, dir])
	node.connect("mouse_exited", self, "_on_mouse_exited", [node])

func _on_mouse_entered(node: Control, dir: String):
	# Make a tooltip if it doesn't already exist for this node
	if not owners.has(node):
		var tooltip = _tooltip_scene.instance()
		add_child(tooltip)

		# Set the text of the tooltip
		tooltip.set_text(node.get_meta("tooltip_text").c_unescape())

		var center = (node.rect_global_position + node.rect_size / 2)
		var tooltip_pos
		match dir:
			"DOWN":
				tooltip_pos = center + Vector2(0, node.rect_size.y / 2)
				tooltip_pos.x -= tooltip.rect_size.x / 2
				tooltip_pos.y += 16
				tooltip.set_dir("DOWN")
			"RIGHT":
				tooltip_pos = center + Vector2(node.rect_size.x / 2, 0)
				tooltip_pos.y -= tooltip.rect_size.y / 2
				tooltip_pos.x += 12
				tooltip.set_dir("RIGHT")
			"UP":
				tooltip_pos = center - Vector2(0, node.rect_size.y / 2)
				tooltip_pos.y -= tooltip.rect_size.y
				tooltip_pos.x -= tooltip.rect_size.x / 2
				tooltip_pos.y -= 16
				tooltip.set_dir("UP")

		tooltip_pos = _clamp_position(tooltip_pos, tooltip)
		tooltip.set_position(tooltip_pos)
		owners[node] = tooltip

func _on_mouse_exited(node: Object):
	if owners.has(node):
		var tooltip = owners[node]
		tooltip.hide_and_delete()
		owners.erase(node)

func _clamp_position(pos, tooltip):
	var final_pos = pos
	var border = get_viewport().size - padding

	# Ensure tooltip doesn't leave right side of the screen
	if final_pos.x + tooltip.rect_size.x > border.x:
		final_pos.x = border.x - tooltip.rect_size.x

	# Ensure tooltip doesn't leave left side of the screen
	if final_pos.x < padding.x / 2:
		final_pos.x = padding.x / 2

	return final_pos
