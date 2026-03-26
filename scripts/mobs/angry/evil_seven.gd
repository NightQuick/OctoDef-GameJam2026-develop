extends CharacterBody2D

@export_category("КАСТОМНЫЕ НАСТРОЙКИ") 
@export_enum("tank", "scooter", "damager") var type_of_attack : String
var is_upgraded: bool = false  # Флаг улучшенного моба

var self_speed : int              #Собственная скорость
var self_speed_before : int       #Скорость до эффектов
var self_health : int             #Собственное здоровье
var self_health_before : int      #Изначальное здоровье
var self_damage : int             #Собственый дамаг   
var effects: Dictionary = {}
var mob_data  # Данные из базы мобов

@onready var NavigationAgent: NavigationAgent2D = find_child("NavigationAgent2D", true, false)
@onready var tile_map_layer: TileMapLayer = get_tree().current_scene.find_child("TileMapLayer", true, false)

var mouse_position = Vector2(0, 0) 
var selected_type_attack

func _ready() -> void:
	# Определяем тип моба и загружаем данные
	determine_mob_type()
	
	# Применяем визуальные эффекты
	apply_visual_effects()
	
	# Устанавливаем статы
	match type_of_attack:
		"tank":
			print(name, ": создан класс танк")
			selected_type_attack = type_of_attack
			self_speed = mob_data.base_speed if mob_data else 10
			self_health = mob_data.base_health if mob_data else 500
			self_damage = mob_data.base_damage if mob_data else 20

		"scooter":
			print(name, ": создан класс скутер")
			selected_type_attack = type_of_attack
			self_speed = mob_data.base_speed if mob_data else 40
			self_health = mob_data.base_health if mob_data else 50
			self_damage = mob_data.base_damage if mob_data else 10

		"damager":
			print(name, ": создан класс дамагер")
			selected_type_attack = type_of_attack
			self_speed = mob_data.base_speed if mob_data else 20
			self_health = mob_data.base_health if mob_data else 20
			self_damage = mob_data.base_damage if mob_data else 35

		_:
			printerr(name, ":не выбран тип атаки юнита ", self)
			get_tree().quit()

	self_health_before = self_health 
	self_speed_before = self_speed
	nearest_target()

func determine_mob_type():
	# Определяем, улучшенный ли это моб
	if is_upgraded:
		match type_of_attack:
			"scooter":
				mob_data = MobDatabase.upgraded_mobs["scooter_upgrade_1"]
			"damager":
				mob_data = MobDatabase.upgraded_mobs["damager_upgrade_1"]
			"tank":
				mob_data = MobDatabase.upgraded_mobs["tank_upgrade_1"]
			_:
				mob_data = MobDatabase.mob_types[type_of_attack]
	else:
		match type_of_attack:
			"scooter":
				mob_data = MobDatabase.mob_types["scooter"]
			"damager":
				mob_data = MobDatabase.mob_types["damager"]
			"tank":
				mob_data = MobDatabase.mob_types["tank"]
			_:
				mob_data = null

func apply_visual_effects():
	if mob_data == null:
		return
	
	# 1. Меняем цвет (модуляция)
	if has_node("Sprite2D"):
		$Sprite2D.modulate = mob_data.color_modulate
	
	# 2. Меняем размер
	scale = Vector2(mob_data.scale_modifier, mob_data.scale_modifier)
	
	# 3. Меняем скорость анимации
	if has_node("AnimationPlayer"):
		$AnimationPlayer.speed_scale = mob_data.animation_speed
	
	# 4. Добавляем эффект для улучшенных мобов
	if mob_data.custom_texture != "":
		add_upgrade_effect()

func add_upgrade_effect():
	# Добавляем дополнительный спрайт для улучшенных мобов
	var glow = Sprite2D.new()
	glow.texture = load(mob_data.custom_texture)
	glow.modulate = Color(1, 1, 1, 0.5)
	add_child(glow)
	
	# Анимация пульсации
	var tween = create_tween()
	tween.tween_property(glow, "modulate:a", 0.8, 0.5).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(glow, "modulate:a", 0.3, 0.5).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()

func _physics_process(_delta: float) -> void:
	Effects.effect(self)
	
	z_index = global_position.y
	evil.die(self)
	
	var self_position = global_position                                            #Позиция моба
	var next_path_position = NavigationAgent.get_next_path_position()              #Путь к следующей позиции моба
	var new_velocity = self_position.direction_to(next_path_position) * self_speed #

	if edit_tile.cords_targets == []:
		NavigationAgent.set_target_position(global_position) 
		return

	if NavigationAgent.is_navigation_finished():
		return 

	if NavigationAgent.avoidance_enabled:
		NavigationAgent.set_velocity(new_velocity) 
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)

	if Input.is_action_just_pressed("mouse_right_button"):
		NavigationAgent.target_position = global_position

	match selected_type_attack:
		"tank":
			TankFunc()
		"scooter":
			ScooterFunc()
		"damager":
			DamagerFunc()

	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func nearest_target():
	if not is_inside_tree():
		return
	await get_tree().process_frame
	var nearest_point = null
	var nearest_distance = INF

	if edit_tile.cords_targets != null and edit_tile.cords_targets.size() > 0:
		for point in edit_tile.cords_targets:
			var global_point = tile_map_layer.map_to_local(point) #ЭТО ПРАВИЛЬНО И ОНО РАБОТАЕТ!!
			var distance = global_position.distance_to(global_point)
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_point = global_point
				
	if nearest_point != null:
		NavigationAgent.target_position = nearest_point

func TankFunc():
	# Специальная логика для танка
	pass    

func ScooterFunc():
	# Специальная логика для скутера
	pass

func DamagerFunc():
	# Специальная логика для дамагера
	pass
