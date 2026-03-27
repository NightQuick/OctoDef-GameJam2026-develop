extends Node

const listResolutions: Dictionary = {
	"1920x1080": Vector2i(1920, 1080),
	"1280x720": Vector2i(1280, 720),
	"1024x768": Vector2i(1024, 768),
	"768x768": Vector2i(768, 768)
}

const WAVE_SETTINGS = {
	"total_waves": 5,
	"base_difficulty": 10,
	"difficulty_increase_per_wave": 15,
	"stat_increase_per_wave": 0.2,
	"speed_increase_per_wave": 0.05,
	"time_between_spawns": 3.0
}

var is_debug: bool = true
var base_cords: Array = []
