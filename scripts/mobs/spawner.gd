extends Node2D

var mobs_list: Array
var waves: int
var time: float

var m1 = scenes_path.scooter
var m2 = scenes_path.damager
var m3 = scenes_path.tank

func _ready() -> void:
	mobs_list = [
		[m1, m2, m1, m1],
		[m2, m2, m3, m3],
		[m3, m3, m3, m3],
	]
	waves = len(mobs_list)
	time = 3
	spawning(mobs_list, waves, time)


func spawning(mobs_list: Array, waves: int, time: float):
	for i in len(mobs_list):
		print("=== ВОЛНА ", i, " ===")
		for j in len(mobs_list[i]):
			await get_tree().create_timer(time).timeout
			print("Прошла ",  time, "  секунд")
			var current_mob = mobs_list[i][j].instantiate()
			get_tree().current_scene.add_child(current_mob)
			current_mob.position = self.position
			print(current_mob.name) 
		await wait_for_enemies_clear()

func wait_for_enemies_clear():
	print("Ожидание уничтожения всех врагов...")
	while not get_tree().get_nodes_in_group("evil").is_empty():
		var count = get_tree().get_nodes_in_group("evil").size()
		print("Осталось врагов: ", count)
		await get_tree().create_timer(1.0).timeout
	print("Все враги уничтожены!")
