class_name WaveGenerator
extends Node

static func generate_waves(player_level: int, total_waves: int = 5) -> Array:
	var generator = WaveGenerator.new()
	var waves = []
	var base_difficulty = player_level * 10
	
	for wave_num in range(total_waves):
		var wave_difficulty = base_difficulty + (wave_num * 15)
		var wave_mobs = generator.generate_wave_mobs(wave_difficulty, player_level, wave_num)
		waves.append(wave_mobs)
	
	return waves

func generate_wave_mobs(difficulty: int, player_level: int, wave_num: int) -> Array:
	var mobs = []  # Массив PackedScene
	var available_mobs = get_available_mobs(player_level, wave_num)
	
	var remaining_difficulty = difficulty
	
	while remaining_difficulty > 0 and available_mobs.size() > 0:
		var selected_mob = select_mob_by_weight(available_mobs)
		
		# Проверяем, что selected_mob не null и имеет scene
		if selected_mob == null or selected_mob.scene == null:
			printerr("Selected mob is invalid!")
			break
			
		var mob_cost = get_mob_cost(selected_mob, wave_num)
		
		if mob_cost <= remaining_difficulty:
			# Добавляем PackedScene, а не объект MobData
			mobs.append(selected_mob.scene)
			remaining_difficulty -= mob_cost
		else:
			var weaker_mob = get_weaker_mob(available_mobs, remaining_difficulty)
			if weaker_mob != null and weaker_mob.scene != null:
				mobs.append(weaker_mob.scene)
				break
			else:
				break
	
	return mobs

func get_available_mobs(player_level: int, wave_num: int) -> Array:
	var mobs = []
	
	# Проверяем, что база данных существует
	if MobDatabase == null:
		printerr("MobDatabase not found!")
		return mobs
	
	# Базовые мобы всегда доступны
	if MobDatabase.mob_types.has("scooter") and MobDatabase.mob_types["scooter"] != null:
		mobs.append(MobDatabase.mob_types["scooter"])
	else:
		printerr("Scooter mob data not found!")
		
	if MobDatabase.mob_types.has("damager") and MobDatabase.mob_types["damager"] != null:
		mobs.append(MobDatabase.mob_types["damager"])
	else:
		printerr("Damager mob data not found!")
		
	if MobDatabase.mob_types.has("tank") and MobDatabase.mob_types["tank"] != null:
		mobs.append(MobDatabase.mob_types["tank"])
	else:
		printerr("Tank mob data not found!")
	
	# Улучшенные мобы разблокируются с уровнем
	if player_level >= 2:
		if MobDatabase.upgraded_mobs.has("scooter_upgrade_1") and MobDatabase.upgraded_mobs["scooter_upgrade_1"] != null:
			mobs.append(MobDatabase.upgraded_mobs["scooter_upgrade_1"])
	
	if player_level >= 3:
		if MobDatabase.upgraded_mobs.has("damager_upgrade_1") and MobDatabase.upgraded_mobs["damager_upgrade_1"] != null:
			mobs.append(MobDatabase.upgraded_mobs["damager_upgrade_1"])
	
	if player_level >= 4:
		if MobDatabase.upgraded_mobs.has("tank_upgrade_1") and MobDatabase.upgraded_mobs["tank_upgrade_1"] != null:
			mobs.append(MobDatabase.upgraded_mobs["tank_upgrade_1"])
	
	return mobs

func select_mob_by_weight(mobs: Array):
	if mobs.size() == 0:
		return null
		
	var total_weight = 0.0
	for mob in mobs:
		if mob != null:
			total_weight += mob.spawn_weight
	
	if total_weight <= 0:
		return mobs[0]
	
	var random_value = randf() * total_weight
	var accumulated_weight = 0.0
	
	for mob in mobs:
		if mob == null:
			continue
		accumulated_weight += mob.spawn_weight
		if random_value <= accumulated_weight:
			return mob
	
	return mobs[0]

func get_mob_cost(mob, wave_num: int) -> int:
	if mob == null:
		return 10
	var base_cost = mob.base_health / 10
	return base_cost + (wave_num * 2)

func get_weaker_mob(mobs: Array, max_cost: int):
	var weaker = []
	for mob in mobs:
		if mob == null:
			continue
		var cost = mob.base_health / 10
		if cost <= max_cost:
			weaker.append(mob)
	
	if weaker.size() > 0:
		return weaker[0]
	return null
