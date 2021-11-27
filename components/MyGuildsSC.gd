extends ScrollContainer

var guilds = [
	{
		"name": "3ddelano Cafe",
		"icon": preload("res://assets/guild_icons/33026445014807347491.webp")
	},
	{
		"name": "TheAwesomeTech",
		"icon": preload("res://assets/guild_icons/369422519129604096.webp")
	},
	{
		"name": "jishiyo ジシヨ",
		"icon": preload("res://assets/guild_icons/306063087641821185.webp")
	},
	{
		"name": "GDD 2021",
		"icon": preload("res://assets/guild_icons/572843650896101392.webp")
	}
]

export (PackedScene) var _guild_icon_button_scene
func _ready() -> void:
	for child in $MC/VB.get_children():
		# Dont remove the HomeIcon and HSeparator
		if child.name != "MC" and child.name != "HS":
			child.visible = false
			child.queue_free()

	for k in range(5):
		for i in range(guilds.size()):
			var guild_data = guilds[i]
			var guild = _guild_icon_button_scene.instance()
			$MC/VB.add_child(guild)
			var model = GuildModel.new(Utils.uuid(), guild_data.name, guild_data.icon)
			guild.from_model(model)

			if k == 0:
				Cache.guilds[model.id] = guild
