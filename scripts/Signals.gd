extends Node

signal register_tooltip(node)
signal guild_hover_indicator(show, global_pos)
signal message_received(message_data)
signal scroll_messages
signal app_ready

var debug = {
	"fps": 0
}

func register_tooltip(node: Object):
	emit_signal("register_tooltip", node)

func show_guild_hover_indicator(global_pos):
	emit_signal("guild_hover_indicator", true, global_pos)

func hide_guild_hover_indicator():
	emit_signal("guild_hover_indicator", false, null)

func scroll_messages():
	emit_signal("scroll_messages")

func add_message(message_data: Dictionary):
	emit_signal("message_received", message_data)
