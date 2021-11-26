extends PanelContainer

onready var _textedit = $MC/ExpandableTextEdit
onready var _placeholder = $MC/PlaceholderText


func _ready() -> void:
	_textedit.connect("text_changed", self, "_on_text_changed")

func _on_text_changed():
	if _textedit.text == "":
		_placeholder.visible = true
	else:
		_placeholder.visible = false
		Signals.scroll_messages()
