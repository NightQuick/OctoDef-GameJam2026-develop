class_name MobDatabase
extends Node

class MobData:
	var scene: PackedScene
	var base_health: int
	var base_speed: int
	var base_damage: int
	var spawn_weight: float
	
	# Визуальные данные
	var color_modulate: Color
	var scale_modifier: float
	var animation_speed: float
	var custom_texture: String  # путь к текстуре, если нужна особая
	
	func _init(scene_path, health, speed, damage, weight, 
			   modulate = Color.WHITE, scale_mod = 1.0, anim_speed = 1.0, texture = ""):
		self.scene = load(scene_path)
		self.base_health = health
		self.base_speed = speed
		self.base_damage = damage
		self.spawn_weight = weight
		self.color_modulate = modulate
		self.scale_modifier = scale_mod
		self.animation_speed = anim_speed
		self.custom_texture = texture

# Базовые типы мобов с разными цветами
static var mob_types = {
	"scooter": MobData.new(
		"res://nodes_scenes/mobs/angry/Scooter.tscn",
		50, 40, 10, 1.0,
		Color(0.3, 0.8, 0.3),  # Зеленый
		1.0,                    # Нормальный размер
		1.2                     # Быстрая анимация
	),
	"damager": MobData.new(
		"res://nodes_scenes/mobs/angry/Damager.tscn",
		100, 25, 25, 0.8,
		Color(0.8, 0.3, 0.3),  # Красный
		1.1,                    # Чуть больше
		0.9                     # Средняя анимация
	),
	"tank": MobData.new(
		"res://nodes_scenes/mobs/angry/Tank.tscn",
		300, 15, 40, 0.5,
		Color(0.3, 0.3, 0.8),  # Синий
		1.2,                    # Большой
		0.7                     # Медленная анимация
	)
}


static var upgraded_mobs = {                      # Улучшенные версии (апгрейды)
	"scooter_upgrade_1": MobData.new(
		"res://nodes_scenes/mobs/angry/Scooter_Upgrade1.tscn",
		80, 50, 15, 0.9,
		Color(0.2, 1.0, 0.2),                   # Ярко-зеленый
		1.1,                                      # Чуть больше
		1.4,                                      # Еще быстрее
		"res://textures/mobs/scooter_glow.png"  # Добавляем свечение
	),
	"damager_upgrade_1": MobData.new(
		"res://nodes_scenes/mobs/angry/Damager_Upgrade1.tscn",
		150, 30, 35, 0.7,
		Color(1.0, 0.2, 0.2),   # Ярко-красный
		1.2,                     # Больше
		1.0,                     # Нормальная анимация
        "res://textures/mobs/damager_flame.png"
	),
	"tank_upgrade_1": MobData.new(
		"res://nodes_scenes/mobs/angry/Tank_Upgrade1.tscn",
		450, 18, 55, 0.4,
		Color(0.2, 0.2, 1.0),   # Ярко-синий
		1.3,                     # Очень большой
		0.8,                     # Медленнее
        "res://textures/mobs/tank_armor.png"
	)
}
