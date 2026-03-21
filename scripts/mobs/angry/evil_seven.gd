extends CharacterBody2D

@export_category("КАСТОМНЫЕ НАСТРОЙКИ") 
@export_enum("tank", "scooter", "damager") var type_of_attack : String

var self_speed : int = 20         #Собственная скорость
var self_health : int = 100       #Собственное здоровье
var self_health_before : int
var self_damage : int = 10        #Собственый дамаг

@onready var NavigationAgent: NavigationAgent2D = $NavigationAgent2D
@onready var hp_bar : TextureProgressBar = $TextureProgressBar
var mouse_position = Vector2(0, 0) 
var selected_type_attack

func _ready() -> void:
	

	
	match type_of_attack:
		"tank": print(name, ": создан класс танк"); selected_type_attack = type_of_attack;\
		self_speed = 10; self_health = 500; self_damage = 20

		"scooter": print(name, ": создан класс скутер"); selected_type_attack = type_of_attack;\
		self_speed = 40; self_health = 50; self_damage = 10

		"damager": print(name, ": создан класс дамагер"); selected_type_attack = type_of_attack;\
		self_speed = 10; self_health = 20; self_damage = 35

		_: printerr(name, ":не выбран тип атаки юнита ", self); get_tree().quit();

	self_health_before = self_health

func _physics_process(_delta: float) -> void:
	
	z_index = global_position.y
#	
	die()
	
	if Input.is_action_just_pressed("ui_accept") and Constants._is_debug_ == true:
		mouse_position = get_global_mouse_position()
		NavigationAgent.target_position = mouse_position
		print(name, ": установлена новая цель - ", mouse_position)

	#var base_cords = Constants.base_cords[0]
	#NavigationAgent.target_position = base_cords

	var self_position = global_position                                            #Позиция моба
	var next_path_position = NavigationAgent.get_next_path_position()              #Путь к следующей позиции моба
	var new_velocity = self_position.direction_to(next_path_position) * self_speed #

	if NavigationAgent.is_navigation_finished():
		return 

	if NavigationAgent.avoidance_enabled:
		NavigationAgent.set_velocity(new_velocity) 
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)

	if Input.is_action_just_pressed("mouse_right_button"):
		NavigationAgent.target_position = global_position
		print(name, ": Цель отменена.")


	match selected_type_attack:
		"tank":
			TankFunc();
		"scooter":
			ScooterFunc();
		"damager":
			DamagerFunc();

	move_and_slide()


func die():
	
	if self_health != self_health_before:  
		var процент = (float(self_health) / float(self_health_before)) * 100
	
		hp_bar.value = процент
		print('&&& ', self_health)
		print('!!! ', self_health_before)
		print(процент)
	
	if self_health <= 0:
		print(name, ' УМЕР.')
		queue_free()

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func TankFunc():
	pass

func ScooterFunc():
	pass

func DamagerFunc():
	pass
