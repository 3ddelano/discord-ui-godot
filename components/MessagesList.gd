extends MarginContainer

export (NodePath) var _messages_vb_path
onready var _messages_vb = get_node(_messages_vb_path) as VBoxContainer

onready var _message_scene = preload("res://components/Message.tscn")


var users = [
	{
		"avatar": preload("res://assets/avatar_icons/321233875776962560.webp"),
		"tag": "3ddelano#6033",
	},
	{
		"avatar": preload("res://assets/avatar_icons/332140864853901313.webp"),
		"tag": "Delano Tatsumi#8248",
	},
	{
		"avatar": preload("res://assets/avatar_icons/907892129630662667.webp"),
		"tag": "Delano's RPG#0137",
	},
]

var messages = [
	"Lorem ipsum dolor sit amet. Quo quidem esse et quae optio aut debitis eligendi ut repellendus labore est ipsam architecto.",

	"Lorem ipsum dolor sit amet.",

	"Nam dolorem repellendus a repudiandae placeat non autem numquam et voluptas tenetur. Et doloribus quia aut iste officia ea reiciendis beatae numquam doloribus! Est numquam quas eum minus blanditiis At sapiente unde.",

	"Aut doloremque amet 33 earum distinctio est saepe rerum est asperiores ipsum et dignissimos laudantium ut saepe illo et alias veritatis. Est animi autem et voluptas distinctio sint aspernatur qui magni sint non galisum harum est nisi voluptate. Qui omnis enim est dolore ipsum non consectetur.",

	"Sit natus reiciendis???",

	"Sed facere error ad placeat officiis et numquam cumque!!!!=",
]


func _ready() -> void:
	_load_messages()
	Signals.connect("scroll_messages", self, "_on_scroll_messages")

func _on_scroll_messages():
	yield(get_tree(), "idle_frame")
	$SC.scroll_vertical = 10000000

func _load_messages():
	for child in _messages_vb.get_children():
		child.queue_free()

	for _i in range(30):
		randomize()

		var content = messages[randi() % messages.size()]

		var message = _message_scene.instance()
		_messages_vb.add_child(message)

		message.set_content(content)
		var user = users[randi() % users.size()]
		if randi() % 2 == 0:
			user.bot = true
		else:
			user.bot = false
		message.set_user(user)
