extends PanelContainer

export (NodePath) var _channels_vb_path
onready var _channels_vb = get_node(_channels_vb_path)
var _channel_scene = preload("res://components/ChannelsListChannel.tscn")


var channels = [
	"status",
	"rules",
	"roles",
	"general",
	"bots",
	"delano-tatusmi",
	"welcome",
	"spam",
	"fornite",
	"valorant",
	"pokemon-game",
	"discord-gd",
	"house-builder",
	"godot",
	"javascript",
	"python",
]
func _ready() -> void:
	_load_channels()

func _load_channels() -> void:
	for child in _channels_vb.get_children():
		child.queue_free()

	for channel_name in channels:
		var channel = _channel_scene.instance()
		channel.set_name(channel_name)
		_channels_vb.add_child(channel)
