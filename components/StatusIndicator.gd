extends Panel

enum STATUS {
	ONLINE,
	IDLE,
	DND,
	INVISIBLE
}

var STRING_STATUS = {
	"ONLINE": STATUS.ONLINE,
	"IDLE": STATUS.IDLE,
	"DND": STATUS.DND,
	"INVISIBLE": STATUS.INVISIBLE
}
var status = STATUS.ONLINE
#export (STATUS) var status = STATUS.ONLINE setget set_status

onready var _online_status = preload("res://components/UserStatus/ONLINE.tscn")
onready var _idle_status = preload("res://components/UserStatus/IDLE.tscn")
onready var _dnd_status = preload("res://components/UserStatus/DND.tscn")
onready var _invisible_status = preload("res://components/UserStatus/INVISIBLE.tscn")

func set_status(p_status):
	if typeof(p_status) == TYPE_STRING:
		p_status = STRING_STATUS[p_status]

	status = p_status

	for child in get_children():
		child.visible = false # Hide if in editor
		if not Engine.is_editor_hint():
			child.queue_free() # Remove if in the main scene

	match status:
		STATUS.ONLINE:
			if Engine.is_editor_hint():
				$ONLINE.visible = true # Unhide if in editor
			else:
				add_child(_online_status.instance())
		STATUS.IDLE:
			if Engine.is_editor_hint():
				$IDLE.visible = true # Unhide if in editor
			else:
				add_child(_idle_status.instance())
		STATUS.DND:
			if Engine.is_editor_hint():
				$DND.visible = true # Unhide if in editor
			else:
				add_child(_dnd_status.instance())
		STATUS.INVISIBLE:
			if Engine.is_editor_hint():
				$INVISIBLE.visible = true # Unhide if in editor
			else:
				add_child(_invisible_status.instance())


