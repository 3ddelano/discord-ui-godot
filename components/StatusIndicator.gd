extends TextureRect

var status = "ONLINE"

onready var _online_status = preload("res://components/UserStatus/ONLINE.tscn")
onready var _idle_status = preload("res://components/UserStatus/IDLE.tscn")
onready var _dnd_status = preload("res://components/UserStatus/DND.tscn")
onready var _invisible_status = preload("res://components/UserStatus/INVISIBLE.tscn")

onready var _status = $StatusIndicator

func set_status(p_status: String):
	status = p_status

	for child in _status.get_children():
		child.queue_free()

	match status:
		"ONLINE":
			_status.add_child(_online_status.instance())
		"IDLE":
			_status.add_child(_idle_status.instance())
		"DND":
			_status.add_child(_dnd_status.instance())
		"INVISIBLE":
			_status.add_child(_invisible_status.instance())
