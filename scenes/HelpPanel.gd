extends PanelContainer

onready var close_button = $CC/PC/MC/VB/HB/CloseButton/Button
onready var github_button = $CC/PC/MC/VB/HB2/HB/GithubButton.get_button()
onready var youtube_button = $CC/PC/MC/VB/HB2/HB/YoutubeButton.get_button()

func _ready() -> void:
	close_button.connect("pressed", self, "_on_close_button_pressed")
	github_button.connect("pressed", self, "_on_github_button_pressed")
	youtube_button.connect("pressed", self, "_on_youtube_button_pressed")

	Signals.connect("show_help", self, "set_visible", [true])

func _on_close_button_pressed():
	visible = false

func _on_github_button_pressed():
	OS.shell_open("https://github.com/3ddelano/discord-ui-godot")

func _on_youtube_button_pressed():
	OS.shell_open("https://www.youtube.com/channel/UCG-5PDEYcmQKkL26opUo0zA")

