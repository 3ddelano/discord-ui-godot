extends PanelContainer

export (NodePath) var _channels_vb_path
onready var _channels_vb = get_node(_channels_vb_path)

var _channel_scene = preload("res://components/ChannelsListChannel.tscn")
var _channel_group_scene = preload("res://components/ChannelsListChannelGroup.tscn")
var _chevron_icon = preload("res://assets/icons/chevron_down.svg")

var channel_groups = {
	"_root": ["status", "rules", "roles"],
	"chat": ["general", "bot", "welcome", "spam"],
	"game": ["fortnite", "valorant", "others"],
	"coding": ["godot", "js", "python"]
}

func _ready() -> void:
	_load_channels()

func _load_channels() -> void:
	for child in _channels_vb.get_children():
		child.queue_free()

	for group_name in channel_groups:
		var group
		if group_name != "_root":
			group = _channel_group_scene.instance()
			group.set_name(group_name.to_upper())
			_channels_vb.add_child(group)

		for channel_name in channel_groups[group_name]:
			var channel = _channel_scene.instance()
			channel.set_name(channel_name)
			_channels_vb.add_child(channel)

			if group is Node:
				group.channels.append(channel)
