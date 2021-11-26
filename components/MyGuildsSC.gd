extends ScrollContainer

var guild_icons = [
	preload("res://assets/guild_icons/33026445014807347491.webp"),
	preload("res://assets/guild_icons/369422519129604096.webp"),
	preload("res://assets/guild_icons/572843650896101392.webp"),
	preload("res://assets/guild_icons/306063087641821185.webp")
]

export (PackedScene) var _guild_icon_button_scene
func _ready() -> void:
	for child in $MC/VB.get_children():
		if child.name != "MC" and child.name != "HS":
			child.visible = false
			child.queue_free()

	for i in range(guild_icons.size()):
		var img = guild_icons[i]
		var _guild_icon = _guild_icon_button_scene.instance()
		_guild_icon.set_icon(img)
		$MC/VB.add_child(_guild_icon)

		_guild_icon = _guild_icon_button_scene.instance()
		_guild_icon.set_icon(img)
		$MC/VB.add_child(_guild_icon)
