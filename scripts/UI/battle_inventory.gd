extends CanvasLayer

var selected_tower: Node2D
var selected_tower_type: int = 0
var placeable: bool = true

# Словарь с количеством башен каждого типа
var type_tower = {
	1: 12,
	2: 32,
	3: 5,
	4: 3,
	5: 2,
	6: 1,
}

# Одна сцена для всех башен
var tower_scene = preload("res://nodes_scenes/towers/first_tower.tscn")

# Текстуры для UI
var tower_textures = {
	1: preload("res://textures/towers/towers_head.png"),
	2: preload("res://textures/towers/towers_head_2.png"),
	3: preload("res://textures/towers/towers_head_3.png"),
	4: preload("res://textures/towers/towers_head_4.png"),
	5: preload("res://textures/towers/towers_head_5.png"),
	6: preload("res://textures/towers/towers_head_6.png"),
}

var frame_size = Vector2(32, 32)

@onready var tile_map = $"../TileMapLayer"
@onready var slots_container = $SlotsContainer

func _ready() -> void:
	load_inventory()
	refresh_inventory_ui()

func get_tower_icon(tower_type: int) -> AtlasTexture:
	var atlas = tower_textures[tower_type]
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = atlas
	atlas_texture.region = Rect2(0, 0, frame_size.x, frame_size.y)
	return atlas_texture

func refresh_inventory_ui():
	if slots_container:
		for child in slots_container.get_children():
			child.queue_free()
	
	for tower_type in type_tower:
		var count = type_tower[tower_type]
		if count > 0:
			create_slot(tower_type, count)

func create_slot(tower_type: int, count: int):
	var slot = Button.new()
	slot.custom_minimum_size = Vector2(80, 80)
	slot.text = str(count)
	slot.icon = get_tower_icon(tower_type)
	slot.set_meta("tower_type", tower_type)
	slot.pressed.connect(_on_slot_pressed.bind(tower_type))
	slots_container.add_child(slot)

func _on_slot_pressed(tower_type: int):
	if selected_tower:
		selected_tower.queue_free()
	
	selected_tower = tower_scene.instantiate()
	selected_tower_type = tower_type
	
	# Устанавливаем тип башне
	selected_tower.type_tower = str(tower_type)
	selected_tower.modulate = Color(1, 1, 1, 0.65)
	
	get_tree().current_scene.add_child(selected_tower)
	print("Выбрана башня типа ", tower_type, ", осталось: ", type_tower[tower_type])

func _process(_delta: float) -> void:
	if selected_tower:
		var mouse_pos = get_tree().current_scene.get_global_mouse_position()
		var cell_pos = tile_map.local_to_map(mouse_pos)
		var tower_pos = tile_map.map_to_local(cell_pos)
		
		selected_tower.global_position = tower_pos
		selected_tower.global_position.y -= 8
		
		check_placeable(cell_pos)
		
		if not placeable:
			selected_tower.modulate = Color(1.0, 0.0, 0.0, 0.65)
		else:
			selected_tower.modulate = Color(1.0, 1.0, 1.0, 0.65)

func check_placeable(cell_pos: Vector2i):
	var scene_towers: Array = get_tree().get_nodes_in_group("tower")
	
	# 1. Проверяем, есть ли тайл в этой клетке
	var tile_data = tile_map.get_cell_tile_data(cell_pos)
	if tile_data == null:
		placeable = false
		return
	
	# 2. Проверяем custom data "buildable"
	var buildable = tile_data.get_custom_data("buildable")
	if buildable == false:
		placeable = false
		return
	
	# 3. Проверяем, не занята ли клетка другой башней
	for tower in scene_towers:
		var tower_cell = tile_map.local_to_map(tower.global_position)
		if tower_cell == cell_pos:
			placeable = false
			return
	
	placeable = true

func _input(event):
	if Input.is_action_just_pressed("mouse_right_button") and selected_tower != null:
		selected_tower.queue_free()
		selected_tower = null
		selected_tower_type = 0
		print("Выбор башни отменен")
	
	if Input.is_action_just_pressed("mouse_left_button"):
		if selected_tower and placeable:
			place_selected_tower()

func place_selected_tower():
	var tower_type = selected_tower_type
	
	# Повторная проверка перед установкой
	var mouse_pos = get_tree().current_scene.get_global_mouse_position()
	var cell_pos = tile_map.local_to_map(mouse_pos)
	
	# Проверяем, свободна ли клетка
	var scene_towers: Array = get_tree().get_nodes_in_group("tower")
	for tower in scene_towers:
		var tower_cell = tile_map.local_to_map(tower.global_position)
		if tower_cell == cell_pos:
			print("Нельзя установить башню на уже существующую!")
			selected_tower.queue_free()
			selected_tower = null
			selected_tower_type = 0
			return
	
	if type_tower[tower_type] > 0:
		type_tower[tower_type] -= 1
		
		var tower = selected_tower
		tower.modulate = Color(1, 1, 1, 1)
		tower.add_to_group("tower")
		tower.z_index = tower.global_position.y
		
		print("Установлена башня типа ", tower_type, ", осталось: ", type_tower[tower_type])
		
		refresh_inventory_ui()
		
		selected_tower = null
		selected_tower_type = 0
	else:
		print("Нет башен типа ", tower_type, " в инвентаре!")
		selected_tower.queue_free()
		selected_tower = null
		selected_tower_type = 0

func add_towers(tower_type: int, amount: int):
	if type_tower.has(tower_type):
		type_tower[tower_type] += amount
	else:
		type_tower[tower_type] = amount
	
	refresh_inventory_ui()
	print("Добавлено ", amount, " башен типа ", tower_type)

func save_inventory():
	var config = ConfigFile.new()
	for tower_type in type_tower:
		config.set_value("inventory", str(tower_type), type_tower[tower_type])
	config.save("user://tower_inventory.cfg")

func load_inventory():
	var config = ConfigFile.new()
	if config.load("user://tower_inventory.cfg") == OK:
		for tower_type in type_tower:
			var saved_count = config.get_value("inventory", str(tower_type), 0)
			if saved_count > 0:
				type_tower[tower_type] = saved_count
		refresh_inventory_ui()
