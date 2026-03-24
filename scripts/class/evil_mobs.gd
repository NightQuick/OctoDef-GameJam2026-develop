class_name evil
extends Node2D

static func die(body):
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
		print(body.name, 'Здоровье до: ', body.self_health_before)
		print(body.name, 'Здоровье после: ', body.self_health)
		print(body.name, 'Процент здоровья: ', health_percentage)
	
	if body.self_health <= 0:
		print(body.name, ' УМЕР.')
		body.queue_free()
