extends CharacterBody2D

@export_category("КАСТОМНЫЕ НАСТРОЙКИ") 
@export_enum("tank", "scooter", "damager") var type_of_attack : String
@export var self_speed : int = 20         #Собственная скорость
@export var self_heath : int = 100        #Собственное здоровье
@export var self_damage : int = 10        #Собственый дамаг

@onready var NavigationAgent: NavigationAgent2D = $NavigationAgent2D
@onready var _is_target_have_ : bool = false #Проверка есть ли цель для навигации
@onready var mouse_position = Vector2(0, 0) 
@onready var selected_type_attack

func _ready() -> void:
	match type_of_attack:
		"tank": print(name,    ": создан класс танк"); selected_type_attack = type_of_attack;\
		self_speed = 10; self_heath = 500; self_damage = 20

		"scooter": print(name, ": создан класс скутер"); selected_type_attack = type_of_attack;\
		self_speed = 40; self_heath = 50; self_damage = 10

		"damager": print(name, ": создан класс дамагер"); selected_type_attack = type_of_attack;\
		self_speed = 10; self_heath = 20; self_damage = 35

		_: printerr(name, ":не выбран тип атаки юнита ", self); get_tree().quit();

func _physics_process(_delta: float) -> void:
	BaseLogic()

	match selected_type_attack:
		"tank":
			TankFunc();
		"scooter":
			ScooterFunc();
		"damager":
			DamagerFunc();

	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func BaseLogic():
	if Input.is_action_just_pressed("mouse_left_button"):
		mouse_position = get_global_mouse_position()
		_is_target_have_ = true
		NavigationAgent.target_position = mouse_position
		print(name, ": установлена новая цель - ", mouse_position)

	if _is_target_have_ == true:
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

func TankFunc():
	pass

func ScooterFunc():
	pass

func DamagerFunc():
	pass
