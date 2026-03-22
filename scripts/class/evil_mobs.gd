#ПОКА ТЕСТОВЫЙ СКРИПТ НИЧЕГО НЕ ИСПОЛЬЗУЕТСЯ
class_name evil

extends Node2D

#var self_speed : int = 20         #Собственная скорость
#var self_heath : int = 100        #Собственное здоровье
#var self_damage : int = 10        #Собственый дамаг


static func die(body, hp_bar = TextureProgressBar):
	
	if body.self_health != body.self_health_before:  
		var health_percentage = (float(body.self_health) / float(body.self_health_before)) * 100
	
		body.hp_bar.value = health_percentage
		print(body.name, 'Здоровье до: ', body.self_health_before)
		print(body.name, 'Здоровье после: ', body.self_health)
		print(body.name, 'Процент здоровья: ', health_percentage)
	
	if body.self_health <= 0:
		print(body.name, ' УМЕР.')
		body.queue_free()
