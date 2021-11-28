extends PanelContainer

export (NodePath) var _panel_path
export (NodePath) var _close_button_path
export (NodePath) var _github_button_path
export (NodePath) var _youtube_button_path
onready var panel = get_node(_panel_path) as PanelContainer
onready var close_button = get_node(_close_button_path)
onready var github_button = get_node(_github_button_path).get_button()
onready var youtube_button = get_node(_youtube_button_path).get_button()
onready var tween = $Tween

func _ready() -> void:
	close_button.connect("pressed", self, "_on_close_button_pressed")
	$Button.connect("pressed", self, "_on_close_button_pressed")
	github_button.connect("pressed", self, "_on_github_button_pressed")
	youtube_button.connect("pressed", self, "_on_youtube_button_pressed")
	panel.rect_pivot_offset = panel.rect_size / 2

	Signals.connect("show_help", self, "_on_show_help")
	visible = true

func _on_close_button_pressed():
	tween.interpolate_property(panel, "rect_scale", Vector2(1, 1), Vector2(0.8, 0.8), 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	visible = false

func _on_show_help():
	tween.interpolate_property(panel, "rect_scale", Vector2(0.8,0.8), Vector2(1,1), 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	visible = true

func _on_github_button_pressed():
	OS.shell_open("https://github.com/3ddelano/discord-ui-godot")

func _on_youtube_button_pressed():
	OS.shell_open("https://www.youtube.com/channel/UCG-5PDEYcmQKkL26opUo0zA")

