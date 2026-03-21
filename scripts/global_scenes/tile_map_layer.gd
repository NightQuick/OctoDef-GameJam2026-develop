extends TileMapLayer

@export var id_atlas = 0
@export var need_tiles = Vector2(1, 1)
@export var need_node = preload("res://nodes_scenes/towers/first_tower.tscn")

func _ready() -> void:
	var all_found_tiles_cord = find_tiles_by_id()
	print(all_found_tiles_cord)
	place_in_tiles(all_found_tiles_cord)
	$"..".add_child(need_node.instantiate())

func find_tiles_by_id():
	var found_cells = []
	# Получаем все занятые клетки на слое
	var used_cells = get_used_cells()
	# Сканируем их
	for cell in used_cells:
		var source_id = get_cell_source_id(cell) #Указывает на атлас тайла на передаваемых координатах
		var atlas_coords = get_cell_atlas_coords(cell)
	# Если ID совпадает с искомым
		if (source_id == id_atlas and atlas_coords[0] == need_tiles[0] and atlas_coords[1] == need_tiles[1]):
			found_cells.append([int(cell[0]), int(cell[1])])
			print("Atlas: ", source_id, " Нашел тайл ID ", atlas_coords, " на координатах: ", cell)

	return found_cells

func place_in_tiles(cords_massive):
	for placing in cords_massive:
		print("d2", placing)
		place_selected_tower(Vector2(placing[0], placing[1]))

func place_selected_tower(pos: Vector2):
	var correct_possition = $"../TileMapLayer".map_to_local($"../TileMapLayer".local_to_map(pos))
	var tower = need_node.instantiate()
	tower.global_position = correct_possition
	#tower.z_index = pos.y
	$"..".add_child(tower)
	print(tower.position, " - possition of tower")
