extends Node

@export var atlas_base_id : int = 0
@export var tiles_base_founding : Vector2 = Vector2(1, 1)
@export var node_spawning : PackedScene = preload("res://nodes_scenes/towers/first_tower.tscn")
@onready var TMap : TileMapLayer = $TileMapLayer

func _ready() -> void:
	place_in_tiles(edit_tile.find_tiles_by_id(atlas_base_id, tiles_base_founding, TMap))
	

func place_in_tiles(cords_massive):
	for placing in cords_massive:
		edit_tile.place_selected_node(self, Vector2(placing[0], placing[1]), node_spawning, TMap)
	print(cords_massive, 'Искомые тайлы')
