extends Node

@export var id_atlas = 0
@export var need_tiles = Vector2(1, 1)
@export var need_node = preload("res://nodes_scenes/towers/first_tower.tscn")
@onready var TMap : TileMapLayer = $TileMapLayer

func _ready() -> void:
	var all_found_tiles_cord = find_tiles_by_id()
	print(all_found_tiles_cord)
	place_in_tiles(all_found_tiles_cord)

func find_tiles_by_id():
	var found_cells = []
	# Получаем все занятые клетки на слое
	var used_cells = TMap.get_used_cells()
	# Сканируем их
	for cell in used_cells:
		var source_id = TMap.get_cell_source_id(cell) #Указывает на атлас тайла на передаваемых координатах
		var atlas_coords = TMap.get_cell_atlas_coords(cell)
	# Если ID совпадает с искомым
		if (source_id == id_atlas and atlas_coords.x == need_tiles.x and atlas_coords.y == need_tiles.y):
			found_cells.append(cell)
			print("Atlas: ", source_id, " Нашел тайл ID ", atlas_coords, " на координатах: ", cell)

	return found_cells

func place_in_tiles(cords_massive):
	for placing in cords_massive:
		print("d2", placing)
		place_selected_tower(Vector2(placing[0], placing[1]), need_node)

func place_selected_tower(possition: Vector2, placed_node: PackedScene):
	var correct_possition = TMap.map_to_local(possition)
	var node = placed_node.instantiate()
	node.global_position = correct_possition
	get_tree().current_scene.add_child(node)
	print(correct_possition, " - possition of tower")
	print(node.position, ' позиция заспавненной ноды')
