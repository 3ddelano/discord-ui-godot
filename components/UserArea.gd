extends PanelContainer

onready var mute_button = $MC/HB/Buttons/MuteButton.get_button()
onready var deafen_button = $MC/HB/Buttons/DeafenButton.get_button()
onready var settings_button = $MC/HB/Buttons/SettingsButton.get_button()


onready var avatar = $MC/HB/AvatarIcon
onready var username = $MC/HB/VB/Username
onready var discriminator = $MC/HB/VB/Discriminator

func _ready() -> void:
	var vb = $MC/HB/VB
	vb.set_meta("tooltip_text", "Click to copy username")
	Signals.register_tooltip(vb, "UP")

	mute_button.set_meta("tooltip_text", "Mute")
	deafen_button.set_meta("tooltip_text", "Deafen")
	settings_button.set_meta("tooltip_text", "User Settings")

	Signals.register_tooltip(mute_button, "UP")
	Signals.register_tooltip(deafen_button, "UP")
	Signals.register_tooltip(settings_button, "UP")

	Signals.connect("app_ready", self, "_on_app_ready")

func _on_app_ready():
	var model = Cache.me_user.model

	avatar.texture = model.avatar
	avatar.set_status(model.status)
	username.text = model.username
	discriminator.text = "#" + model.discriminator
