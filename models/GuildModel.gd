class_name GuildModel extends BaseModel

var _name: String
var icon: Texture

func _init(p_id: String, p_name: String, p_icon: Texture).(BaseModel.ModelTypes.GUILD, p_id):
	_name = p_name
	icon = p_icon
