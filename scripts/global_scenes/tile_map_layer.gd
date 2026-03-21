extends Node

@export var atlas_base_id : int = 0
@export var tiles_base_founding : Vector2 = Vector2(1, 1)
@export var tiles_spawner_founding : Vector2 = Vector2(1, 3)
@export var first_tower_node : PackedScene = preload("res://nodes_scenes/towers/first_tower.tscn")
@export var evil_seve_node : PackedScene = preload("res://nodes_scenes/mobs/angry/evil_seven.tscn")
@onready var TMap : TileMapLayer = $TileMapLayer

func _ready() -> void:
	place_in_tiles(edit_tile.find_tiles_by_id(atlas_base_id, tiles_base_founding, TMap), first_tower_node)
	place_in_tiles(edit_tile.find_tiles_by_id(atlas_base_id, tiles_spawner_founding, TMap), evil_seve_node)

func place_in_tiles(cords_massive, spawning_node):
	for placing in cords_massive:
		edit_tile.place_selected_node(self, Vector2(placing[0], placing[1]), spawning_node, TMap)
	print(cords_massive, 'Искомые тайлы')
