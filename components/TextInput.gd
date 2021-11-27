extends PanelContainer

onready var _textedit = $HB/MC2/ExpandableTextEdit
onready var _placeholder = $HB/MC2/PlaceholderText


func _ready() -> void:
	_textedit.connect("text_changed", self, "_on_text_changed")
	_textedit.grab_focus()

func _on_text_changed():
	if _textedit.text == "":
		_placeholder.visible = true
	else:
		_placeholder.visible = false
		Signals.scroll_messages()
