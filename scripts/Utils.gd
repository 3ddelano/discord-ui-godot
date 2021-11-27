extends Node

static func rand_int(max_value):
	randomize()
	return randi() % max_value

static func rand_bytes(n):
	var r = []
	for _i in range(0, n):
		r.append(rand_int(256))

	return r

static func uuidbin():
	var b = rand_bytes(16)

	b[6] = (b[6] & 0x0f) | 0x40
	b[8] = (b[8] & 0x3f) | 0x80
	return b

static func uuid():
	var b = uuidbin()

	var low = '%02x%02x%02x%02x' % [b[0], b[1], b[2], b[3]]
	var mid = '%02x%02x' % [b[4], b[5]]
	var hi = '%02x%02x' % [b[6], b[7]]
	var clock = '%02x%02x' % [b[8], b[9]]
	var node = '%02x%02x%02x%02x%02x%02x' % [b[10], b[11], b[12], b[13], b[14], b[15]]

	return '%s-%s-%s-%s-%s' % [low, mid, hi, clock, node]

static func get_cur_time_string() -> String:
	var time = OS.get_time()
	var meridian = "AM"
	if time.hour > 12:
		time.hour -= 12
		meridian = "PM"

	return "%s:%s %s" % [str(time.hour), str(time.minute).pad_zeros(2), meridian]
