extends CanvasLayer

var selected_tower: Node2D
var selected_tower_last_pos: Vector2
var placeable: bool = true

#Башни (В дальнейшем надо сделать глобальный список всех башен, а не хранить их в коде инвентаря)
var test_tower = preload("res://nodes_scenes/towers/first_tower.tscn")

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if selected_tower:
		selected_tower.global_position = $"../TileMapLayer".map_to_local($"../TileMapLayer".local_to_map($"..".get_global_mouse_position()))
		selected_tower.global_position.y -= 8
		selected_tower_last_pos = Vector2(selected_tower.global_position.x, selected_tower.global_position.y-1)
		if not placeable:
			selected_tower.modulate = Color(1.0, 0.0, 0.0, 1.0)
		else: selected_tower.modulate = Color(1.0, 1.0, 1.0, .65)
		
		if selected_tower_last_pos != selected_tower.global_position:
			chek_placeable()

func _on_slot_template_pressed() -> void:
	if not selected_tower:
		selected_tower = $SlotTemplate/Texture.duplicate()
		$"..".add_child(selected_tower)

func _input(_event):
	if Input.is_action_just_pressed("mouse_right_button") and selected_tower != null:
		selected_tower.queue_free()
	if Input.is_action_just_pressed("mouse_left_button"):
		if selected_tower and placeable:
			place_selected_tower(selected_tower.global_position)

func chek_placeable():
	var scene_towers: Array = get_tree().get_nodes_in_group("tower")
	for i in scene_towers:
		if selected_tower.global_position == i.global_position:
			placeable = false
			break
		else: 
			placeable = true

func place_selected_tower(pos: Vector2):
	var tower = test_tower.instantiate()
	tower.global_position = pos
	tower.z_index = pos.y
	$"..".add_child(tower)
