class_name PersistentData

static var max_speed_y: float = 50.0
static var achievements: Array[String] = []

static var runs_since_right_click_ach: int = 0
static var is_right_click_run: bool = false

static func unlock_achievement(id: String) -> void:
	if not achievements.has(id):
		achievements.push_back(id)
