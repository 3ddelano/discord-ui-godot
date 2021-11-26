extends ReferenceRect

export (PackedScene) var _tooltip_scene

var tooltips = []
var owners = {}

export (Vector2) var padding = Vector2(8, 8)

func _ready() -> void:
	Signals.connect("register_tooltip", self, "_on_register_tooltip")

func make_tooltip(pos: Vector2, text: String) -> Node:
	var tooltip = _tooltip_scene.instance()
	add_child(tooltip)
	tooltip.set_text(text)
	var size = tooltip.rect_size
	var final_pos = pos
	final_pos.x -= size.x / 2
	final_pos.y += 16 # Moves the tooltip a little lower so that the triangle is below pos

	var border = get_viewport().size - padding
	if final_pos.x + size.x > border.x:
		final_pos.x = border.x - size.x

	if final_pos.x < padding.x / 2:
		final_pos.x = padding.x / 2

	tooltip.set_position(final_pos)
	tooltip.visible = false
	tooltip.call_deferred("set_visible", true)
	return tooltip

func _on_register_tooltip(node: Object):
	assert(node is Control, "Expected " + node.name + " to be a Control")
	node.connect("mouse_entered", self, "_on_mouse_entered", [node])
	node.connect("mouse_exited", self, "_on_mouse_exited", [node])

func _on_mouse_entered(node: Control):
	# Make a tooltip if it doesn't already exist for this node
	if not owners.has(node):
		var tooltip_pos = node.rect_global_position + node.rect_size / 2 + Vector2(0, node.rect_size.y / 2)
		var tooltip = make_tooltip(tooltip_pos, node.get_meta("tooltip_text").c_unescape())
		owners[node] = tooltip

func _on_mouse_exited(node: Object):
	if owners.has(node):
		var tooltip = owners[node]
		tooltip.hide_and_delete()#queue_free()
		owners.erase(node)
