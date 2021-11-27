class_name UserModel extends BaseModel

var username: String
var discriminator: String
var avatar: Texture
var bot: bool
var activity: String
var status: String

func _init(p_id: String, p_username: String, p_discriminator: String, p_avatar: Texture, p_bot: bool, p_activity: String, p_status: String).(BaseModel.ModelTypes.USER, p_id):
	username = p_username
	discriminator = p_discriminator
	avatar = p_avatar
	bot = p_bot
	activity = p_activity
	status = p_status
