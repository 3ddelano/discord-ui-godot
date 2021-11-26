extends PanelContainer

export (NodePath) var _avatar_path
export (NodePath) var _tag_path
export (NodePath) var _bot_path
export (NodePath) var _timestamp_path
export (NodePath) var _content_path

onready var avatar = get_node(_avatar_path) as TextureRect
onready var tag = get_node(_tag_path) as Label
onready var bot = get_node(_bot_path) as PanelContainer
onready var timestamp = get_node(_timestamp_path) as Label
onready var content = get_node(_content_path) #as ExpandableTextEdit

onready var _hover_panel = $Hover as Panel

var _message_max_size_offset = 483 - 350
func _ready() -> void:
	_hover_panel.visible = false
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	get_tree().connect("screen_resized", self, "_on_resized")
	Datastore.connect("users_list_visible", self, "_on_user_list_visible")
	Datastore.connect("maximized", self, "_on_maximized")

func _on_resized():
	content._on_text_changed()
	Signals.scroll_messages()

func _on_user_list_visible(_value):
	visible = false
	content._on_text_changed()
	call_deferred("set_visible", true)

func _on_maximized(_value):
	yield(get_tree().create_timer(0.1), "timeout")
	visible = false
	content._on_text_changed()
	call_deferred("set_visible", true)

func _on_mouse_entered():
	_hover_panel.visible = true

func _on_mouse_exited():
	_hover_panel.visible = false

func set_user(p_user: Dictionary) -> void:
	assert(p_user.has("tag"), "Missing tag in Message.set_user")
	assert(p_user.has("bot"), "Missing bot in Message.set_user")

	if p_user.has("avatar"):
		avatar.texture = p_user.avatar
	else:
		avatar.queue_free()

	tag.text = p_user.tag
	if not p_user.bot:
		bot.queue_free()

func set_content(p_content) -> void:
	content.text = str(p_content)
	content._on_text_changed()

func set_timestamp(p_timestamp: String) -> void:
	timestamp = p_timestamp
