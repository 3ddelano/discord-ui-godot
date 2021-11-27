extends PanelContainer

var model: MessageModel

export (NodePath) var _avatar_path
export (NodePath) var _tag_path
export (NodePath) var _bot_path
export (NodePath) var _timestamp_path
export (NodePath) var _content_path
export (NodePath) var _hover_panel_path

onready var avatar = get_node(_avatar_path) as TextureRect
onready var tag = get_node(_tag_path) as Label
onready var bot = get_node(_bot_path) as PanelContainer
onready var timestamp = get_node(_timestamp_path) as Label
onready var content = get_node(_content_path) #as ExpandableTextEdit
onready var _hover_panel = get_node(_hover_panel_path) as PanelContainer

onready var _grouped_timestamp = preload("res://components/MessageGroupedTimestamp.tscn")

func _ready() -> void:
	_hover_panel.visible = false
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	Datastore.connect("users_list_visible", self, "_on_user_list_visible")


func _on_user_list_visible(_value):
	visible = false
	content._on_text_changed()
	call_deferred("set_visible", true)

func _on_mouse_entered():
	_hover_panel.visible = true

func _on_mouse_exited():
	_hover_panel.visible = false

func set_user(model: UserModel) -> void:
	avatar.texture = model.avatar
	tag.text = model.username + "#" + model.discriminator
	if not model.bot:
		bot.queue_free()

func set_content(p_content) -> void:
	content.text = str(p_content)
	content._on_text_changed(true)

func set_timestamp(p_timestamp: String) -> void:
	timestamp.text = p_timestamp

func from_model(p_model: MessageModel):
	model = p_model
	set_timestamp(model.timestamp)
	set_user(Cache.users[model.author_id].model)
	set_content(model.content)

func grouped():
	avatar.visible = false
	$MC/MC/VB/Header.visible = false
	content.add_constant_override("line_spacing", 0)
	$MC.add_constant_override("margin_top", 0)
	$MC.add_constant_override("margin_bottom", 0)
	content._on_text_changed(true)
	var grouped_timestamp = _grouped_timestamp.instance()
	$Hover.add_child(grouped_timestamp)
	grouped_timestamp.get_node("MessageTimestamp").text = model.timestamp.lstrip("Today at ")
