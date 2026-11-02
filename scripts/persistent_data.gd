class_name PersistentData

static var max_speed_y: float = 50.0
static var achievements: Array[String] = []

static func unlock_achievement(id: String) -> void:
	if not achievements.has(id):
		achievements.push_back(id)
