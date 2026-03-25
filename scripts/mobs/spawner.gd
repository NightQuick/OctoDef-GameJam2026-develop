extends Node2D

var mobs_list: Array
var waves: int
var time: float

var _is_mob_list_end_ : bool

var is_running: bool = true                          # Основной флаг(Ложь в конце кода при завершении)
 
var m1 = scenes_path.scooter
var m2 = scenes_path.damager
var m3 = scenes_path.tank

func _ready() -> void:
	#print(self.position, ' GLOBALNIE COORDINATI')   # ОТЛАДКА
	mobs_list = [
		[m1, m2, m1, m1],
		[m2, m2, m3, m3],
		[m3, m3, m3, m3],
		[m1, m2, m1, m1],
		[m2, m2, m3, m3],
		[m3, m3, m3, m3], 
		[m1], [m2], [m3]
	]
	_is_mob_list_end_ = false
	time = 5
	spawning(mobs_list, time)

#func _process(_delta: float) -> void:
	#print(count_evil)

func spawning(mobs_list: Array, time: float):
	for i in len(mobs_list):                                    # Цикл волны
		if not is_running: break                                # Проверка-сброс
		print("=== ВОЛНА ", i, " ===") 
		for j in len(mobs_list[i]):                             # Цикл каждого вызываемого моба в волне
			if not is_running: break                            # Проверка-сброс
			await get_tree().create_timer(time).timeout         # Таймер для небольшой задержки перед спавном
			if not is_running: break                            # Проверка-сброс
			#print("Прошла ",  time, "  секунд")                # ОТЛАДКА
			var current_mob = mobs_list[i][j].instantiate()     # Делаем экземпляр моба из двумерного массива
			current_mob. add_to_group("evil")                   # Добавляем в группу зла
			current_mob.global_position = self.global_position  # Спавн на позиции спавнера
			get_tree().current_scene.add_child(current_mob)     # Создаем моба на корневой сцене
		if not is_running: break                                # Проверка-сброс
		await wait_for_enemies_clear()                          # Ждем выполнения "пока все мобы не сдохнут"
	
	
	if is_running:                                              # Проверка прошел ли код весь путь?
		victory()                                               # Вызов функции с изменением is_running на ложь
		
func wait_for_enemies_clear():
	print("Ожидание уничтожения всех врагов...")
	while is_running:
		if not is_running: break                                           
		if get_tree() == null:
			return
		var count_evil = get_tree().get_nodes_in_group("evil")
		if count_evil.is_empty():
			break
		print("Осталось врагов: ", count_evil.size())
		await get_tree().create_timer(1.0).timeout
	
	if is_running:
		print("Все враги уничтожены!")
	
func victory():
	is_running = false # Останавливаем все циклы
	print("ПОБЕДА!")
	if is_inside_tree():
		get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
