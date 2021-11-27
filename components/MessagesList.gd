extends MarginContainer

export (NodePath) var _messages_vb_path
onready var _messages_vb = get_node(_messages_vb_path) as VBoxContainer
onready var _message_scene = preload("res://components/Message.tscn")
var last_author


var messages = [
	"Lorem ipsum dolor sit amet. Quo quidem esse et quae optio aut debitis eligendi ut repellendus labore est ipsam architecto.",

	"Lorem ipsum dolor sit amet.",

	"Nam dolorem repellendus a repudiandae placeat non autem numquam et voluptas tenetur. Et doloribus quia aut iste officia ea reiciendis beatae numquam doloribus! Est numquam quas eum minus blanditiis At sapiente unde.",

	"Aut doloremque amet 33 earum distinctio est saepe rerum est asperiores ipsum et dignissimos laudantium ut saepe illo et alias veritatis. Est animi autem et voluptas distinctio sint aspernatur qui magni sint non galisum harum est nisi voluptate. Qui omnis enim est dolore ipsum non consectetur.",

	"Sit natus reiciendis???",

	"Sed facere error ad placeat officiis et numquam cumque!!!!=",
]


func _ready() -> void:
	Signals.connect("scroll_messages", self, "_on_scroll_messages")
	Signals.connect("app_ready", self, "_on_app_ready")
	Signals.connect("message_received", self, "_on_message_received")
	_messages_vb.connect("item_rect_changed", self, "_on_vb_item_rect_changed")

func _on_vb_item_rect_changed():
	yield(get_tree().create_timer(0.01), "timeout")
	for child in _messages_vb.get_children():
		child.content._on_text_changed(true)

func _on_app_ready():
	_load_messages()

func _on_scroll_messages():
	yield(get_tree(), "idle_frame")
	$SC.scroll_vertical = 10000000

func _load_messages():
	for child in _messages_vb.get_children():
		child.queue_free()

	for _i in range(30):
		randomize()

		var content = messages[randi() % messages.size()]
		var author = Cache.users[Cache.users.keys()[randi() % Cache.users.size()]]
		last_author = author

		var message = _message_scene.instance()
		_messages_vb.add_child(message)

		var model = MessageModel.new(Utils.uuid(), content, author.model.id, "Today at " + Utils.get_cur_time_string())
		message.from_model(model)

	Signals.scroll_messages()

func _on_message_received(model: MessageModel):
	var message = _message_scene.instance()
	_messages_vb.add_child(message)
	message.from_model(model)

	# Check if the last author who sent a message is the same as the current one
	var last_author_id = last_author.model.id
	var cur_author_id = model.author_id

	if last_author_id == cur_author_id:
		# Group the message with the prev one
		message.grouped()

	Signals.scroll_messages()
	last_author = Cache.users[cur_author_id]
