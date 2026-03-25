extends Node

@export var atlas_base_id : int = 0
  
@export var tiles_spawner_founding : Vector2 = Vector2(1, 3)
var spawner_node = scenes_path.spawner

@export var tiles_target_founding : Vector2 = Vector2(1, 1)
var target_tower_node = scenes_path.target_tower_node

@onready var TMap : TileMapLayer = $TileMapLayer

func _ready() -> void:
	cords_objects()
	place_in_tiles(edit_tile.cords_spawners, spawner_node)
	place_in_tiles(edit_tile.cords_targets, target_tower_node)

func cords_objects():
	edit_tile.cords_spawners = []
	edit_tile.cords_targets = []
	edit_tile.cords_spawners = edit_tile.find_tiles_by_id(atlas_base_id, tiles_spawner_founding, TMap)
	edit_tile.cords_targets = edit_tile.find_tiles_by_id(atlas_base_id, tiles_target_founding, TMap)
		

func place_in_tiles(cords_massive, spawning_node):
	for placing in cords_massive:
		edit_tile.place_selected_node(self, Vector2(placing[0], placing[1]), spawning_node, TMap)
	print(cords_massive, 'Искомые тайлы')
