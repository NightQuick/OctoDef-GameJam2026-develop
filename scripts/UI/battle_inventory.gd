extends CanvasLayer

var selected_tower: Node2D
var placeable: bool = true

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if selected_tower:
		selected_tower.global_position = $"../TileMapLayer".map_to_local($"../TileMapLayer".local_to_map($"..".get_global_mouse_position()))
		selected_tower.global_position.y -= 8
		$Mouse.global_position = selected_tower.global_position
		if not placeable:
			selected_tower.modulate = Color(1.0, 0.0, 0.0, 1.0)
		else: selected_tower.modulate = Color(1.0, 1.0, 1.0, .65)
		

func _on_slot_template_pressed() -> void:
	if not selected_tower:
		selected_tower = $SlotTemplate/Texture.duplicate()
		$"..".add_child(selected_tower)

func _input(_event):
	if Input.is_action_just_pressed("mouse_right_button"):
		selected_tower.queue_free()

func _on_mouse_body_entered(body: Node2D) -> void:
	if body.is_in_group("tower"):
		placeable = false

func _on_mouse_body_exited(body: Node2D) -> void:
	if body.is_in_group("tower"):
		placeable = true
