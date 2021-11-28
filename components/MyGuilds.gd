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
		"name": "Saiponath's Games",
		"icon": preload("res://assets/guild_icons/661565824384892928.webp")
	}
]

export (PackedScene) var _guild_icon_button_scene
onready var _guilds_vb = $MC/VB
func _ready() -> void:
	_load_guilds()

func _load_guilds():
	for child in _guilds_vb.get_children():
		# Dont remove the HomeIcon and HSeparator
		if child.name != "MC" and child.name != "HS":
			child.visible = false
			child.queue_free()

	for k in range(5):
		for i in range(guilds.size()):
			var guild_data = guilds[i]
			var guild = _guild_icon_button_scene.instance()
			_guilds_vb.add_child(guild)
			var model = GuildModel.new(Utils.uuid(), guild_data.name, guild_data.icon)
			guild.from_model(model)
			Signals.register_tooltip(guild, "RIGHT")

			if k == 0:
				Cache.guilds[model.id] = guild

	# The selected guild will be the first guild in the list
	var selected_guild = _guilds_vb.get_child(2)
	var selected_indicator = $MC/RR/SelectedGuildIndicator
	selected_indicator.rect_global_position.y = selected_guild.rect_global_position.y + (selected_guild.rect_size.y / 2)
	selected_indicator.rect_global_position.y -= selected_indicator.rect_size.y / 2
