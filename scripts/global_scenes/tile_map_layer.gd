extends Node

@export var atlas_id : int = 0
@export var tiles_founding : Vector2 = Vector2(1, 1)
@export var node_spawning : PackedScene = preload("res://nodes_scenes/towers/first_tower.tscn")
@onready var TMap : TileMapLayer = $TileMapLayer

func _ready() -> void:
	var a = place_in_tiles(edit_tile.find_tiles_by_id(atlas_id, tiles_founding, TMap))
	print(a, 'Искомые тайлы')

func place_in_tiles(cords_massive):
	for placing in cords_massive:
		print("d2", placing)
		#place_selected_tower(Vector2(placing[0], placing[1]), need_node)
		edit_tile.place_selected_tower(self, Vector2(placing[0], placing[1]), node_spawning, TMap)
