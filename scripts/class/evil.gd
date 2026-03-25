class_name evil
extends Node2D

static func die(body):
	var body_pos = body.global_position - Vector2(0, -8)
	var tile_map_layer: TileMapLayer = body.get_tree().current_scene.find_child("TileMapLayer", true, false)
	var level_script = body.get_tree().current_scene
	var hp_bar = body.get_node_or_null("HPBar")
	
	if not hp_bar:
			hp_bar = scenes_path.hp_bar.instantiate()
			hp_bar.name = "HPBar"
			body.add_child(hp_bar)
			# Убеждаемся, что это правильный тип
			await body.ready
	
	if body.self_health == body.self_health_before:
		hp_bar.visible = false
	else:
		hp_bar.visible = true 
		
	if body.self_health != body.self_health_before: 
		var health_percentage = (float(body.self_health) / float(body.self_health_before)) * 100
	
		hp_bar.value = health_percentage

		#print(body.name, 'Здоровье до: ', body.self_health_before)
		#print(body.name, 'Здоровье после: ', body.self_health)
		#print(body.name, 'Процент здоровья: ', health_percentage)
	
	if body.self_health <= 0:
		if body.is_in_group("target_tower"):
			var source_id = 0 
			var atlas_coords = Vector2i(0, 0)
			var local_pos = tile_map_layer.to_local(body_pos)
			var cell_pos = tile_map_layer.local_to_map(local_pos)
			# Установка тайла: set_cell(координаты, source_id, atlas_coords)
			tile_map_layer.set_cell(cell_pos, source_id, atlas_coords)
			print(cell_pos, 'sravnenie ', source_id, atlas_coords)
		print(body.name,  ' УМЕР.')
		
		body.queue_free()
		level_script.cords_objects()
