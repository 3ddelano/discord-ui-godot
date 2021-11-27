class_name MessageModel extends BaseModel

var content: String
var author_id: String
var timestamp: String

func _init(p_id: String, p_content: String, p_author_id: String, p_timestamp: String).(BaseModel.ModelTypes.MESSAGE, p_id):
	content = p_content
	author_id = p_author_id
	timestamp = p_timestamp
