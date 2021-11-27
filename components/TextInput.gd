extends PanelContainer

onready var _textedit = $HB/MC2/ExpandableTextEdit
onready var _placeholder = $HB/MC2/PlaceholderText


func _ready() -> void:
	_textedit.connect("text_changed", self, "_on_text_changed")
	_textedit.grab_focus()

	var gift_btn = $HB/MC3/HB/GiftButton
	var gift_text = "Upgrade your friends!\nGift them awesome chat\nperks with Nitro."
	gift_btn.get_button().set_meta("tooltip_text", gift_text)
	Signals.register_tooltip(gift_btn.get_button(), "UP")

func _on_text_changed():
	if _textedit.text == "":
		_placeholder.visible = true
	else:
		_placeholder.visible = false
		Signals.scroll_messages()
