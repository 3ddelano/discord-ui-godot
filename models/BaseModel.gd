class_name BaseModel extends Object
enum ModelTypes {USER, MESSAGE, CHANNEL, GUILD}

var model_type: int
var id: String

func _init(p_model_type: int, p_id: String):
	model_type = p_model_type
	id = p_id
