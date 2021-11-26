class_name UserModel extends BaseModel

var tag: String
var avatar: Texture
var bot: bool
var activity: String
var status: String

func _init(p_id: String, p_tag: String, p_avatar: Texture, p_bot: bool, p_activity: String, p_status: String).(BaseModel.ModelTypes.USER, p_id):
	tag = p_tag
	avatar = p_avatar
	bot = p_bot
	activity = p_activity
	status = p_status
