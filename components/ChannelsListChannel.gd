extends PanelContainer

func set_icon(p_texture: Texture)  -> void:
	$MC/HB/Icon.texture = p_texture

func set_name(p_name: String) -> void:
	$MC/HB/Name.text = p_name
