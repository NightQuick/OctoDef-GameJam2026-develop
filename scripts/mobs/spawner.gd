extends Node2D

var current_wave: int = 0
var total_waves: int = 5
var player_level: int = 1
var time_between_spawns: float = 3.0

var is_running: bool = true
var current_wave_mobs: Array = []

var m1 = scenes_path.scooter
var m2 = scenes_path.damager
var m3 = scenes_path.tank

func _ready() -> void:
	load_player_data()
	start_game()

func load_player_data():
	# Загружаем уровень игрока (можно из файла сохранений)
	var config = ConfigFile.new()
	if config.load("user://player_data.cfg") == OK:
		player_level = config.get_value("player", "level", 1)
	else:
		player_level = 1

func save_player_data():
	var config = ConfigFile.new()
	config.set_value("player", "level", player_level)
	config.save("user://player_data.cfg")

func start_game():
	print("Игрок уровень: ", player_level)
	generate_and_start_waves()

func generate_and_start_waves():
	var waves_data = WaveGenerator.generate_waves(player_level, total_waves)
	spawn_waves(waves_data)

func spawn_waves(waves_data: Array):
	for wave_idx in range(waves_data.size()):
		if not is_running:
			return
		
		print("=== ВОЛНА ", wave_idx + 1, " ===")
		current_wave = wave_idx
		current_wave_mobs = waves_data[wave_idx]
		
		# Спавним мобов волны
		for mob_scene in current_wave_mobs:
			if not is_running:
				return
			
			await get_tree().create_timer(time_between_spawns).timeout
			if not is_running:
				return
			
			var mob = mob_scene.instantiate()
			mob.add_to_group("evil")
			mob.global_position = self.global_position
			
			# Масштабируем статы моба в зависимости от волны
			scale_mob_stats(mob, wave_idx)
			
			get_tree().current_scene.add_child(mob)
		
		# Ждем очистки волны
		await wait_for_enemies_clear()
		
		if not is_running:
			return
	
	# Все волны пройдены
	level_up()

func scale_mob_stats(mob, wave_idx: int):
	# Увеличиваем сложность мобов с каждой волной
	var scale_multiplier = 1.0 + (wave_idx * 0.2)  # +20% к статам за волну
	
	if mob.has_method("get"):
		mob.self_health = int(mob.self_health_before * scale_multiplier)
		mob.self_health_before = mob.self_health
		mob.self_speed = int(mob.self_speed_before * (1.0 + (wave_idx * 0.05)))  # +5% скорости за волну
		mob.self_damage = int(mob.self_damage * scale_multiplier)

func wait_for_enemies_clear():
	print("Ожидание уничтожения всех врагов...")
	
	while is_running:
		var tree = get_tree()
		if tree == null:
			return
		
		var evil_group = tree.get_nodes_in_group("evil")
		if evil_group.is_empty():
			break
		
		print("Осталось врагов: ", evil_group.size())
		await tree.create_timer(1.0).timeout
	
	if is_running:
		print("Волна ", current_wave + 1, " уничтожена!")

func level_up():
	player_level += 1
	save_player_data()
	print("УРОВЕНЬ ПОВЫШЕН! Текущий уровень: ", player_level)
	victory()

func victory():
	is_running = false
	print("ПОБЕДА! Вы прошли все волны!")
	
	if is_inside_tree():
		get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")

func game_over():
	# Сбрасываем уровень при поражении
	player_level = 1
	save_player_data()
	print("ПОРАЖЕНИЕ! Уровень сброшен до 1")
	
	is_running = false
	if is_inside_tree():
		get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
