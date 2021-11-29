extends PanelContainer

var model: UserModel

export (NodePath) var _username_path
export (NodePath) var _bot_path
export (NodePath) var _activity_path
export (NodePath) var _avatar_path

onready var username = get_node(_username_path) as Label
onready var avatar = get_node(_avatar_path) as TextureRect
onready var bot = get_node(_bot_path) as PanelContainer
onready var activity = get_node(_activity_path) as Label

func set_avatar(p_texture: Texture) -> void:
	avatar.texture = p_texture

func set_username(p_username: String) -> void:
	username.text = p_username

func set_activity(p_activity: String) -> void:
	activity.text = p_activity

func set_bot(p_bot: bool) -> void:
	bot.visible = p_bot
	if not p_bot:
		bot.queue_free()

func set_status(p_status: String):
	avatar.set_status(p_status)

func from_model(p_model: UserModel):
	model = p_model
	set_username(model.username)
	set_avatar(model.avatar)
	set_bot(model.bot)
	set_activity(model.activity)
	set_status(model.status)
