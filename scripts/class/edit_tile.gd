class_name edit_tile


static func convert_cords(possition: Vector2, GettingTileMap: TileMapLayer) -> Vector2i:
	var correct_possition = GettingTileMap.map_to_local(possition)
	return correct_possition

#Hopper
static func place_selected_node(tree_scene, possition: Vector2, placed_node: PackedScene, GettingTileMap: TileMapLayer):
	var correct_possition = GettingTileMap.map_to_local(possition)
	var node = placed_node.instantiate()
	node.global_position = correct_possition
	tree_scene.add_child(node)
	#print(correct_possition, " - possition of tower")
	print(node.position, ' - позиция заспавненной ноды')

#Hopper: Находит на карте из определенного атласа все конкретные тайлы по id 
static func find_tiles_by_id(id_atlas : int, need_tiles : Vector2i, TMap : TileMapLayer) -> Array:
	var used_cells = TMap.get_used_cells()
	var found_cells = []
	# Сканируем их
	for cell in used_cells:
		var source_id = TMap.get_cell_source_id(cell) #Указывает на атлас тайла на передаваемых координатах
		var atlas_coords = TMap.get_cell_atlas_coords(cell)
	# Если ID совпадает с искомым
		if (source_id == id_atlas and atlas_coords.x == need_tiles.x and atlas_coords.y == need_tiles.y):
			found_cells.append(cell)
			print("\n Atlas ID: ", source_id, "\n Нашел тайл ID: ", atlas_coords, "\n На координатах: ", cell)
	return found_cells
