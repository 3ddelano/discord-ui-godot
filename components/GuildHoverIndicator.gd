extends Panel

onready var _anim = $AnimationPlayer

func _ready() -> void:
	Signals.connect("guild_hover_indicator", self, "_on_guild_hover_indicator")

func _on_guild_hover_indicator(show, global_pos):
	if show:
		visible = true
		_anim.play("show")
		set_global_position(Vector2(rect_global_position.x, global_pos.y - rect_size.y/2))
	else:
		_anim.play("hide")
