extends Node

func _ready():
	# Находим emitter и подключаемся к сигналу
	var emitter = get_node("../Emitter")
	emitter.connect("swich_to_scene", Callable(self, "_on_switch_to_scene"))
	
func _on_switch_to_scene(sceneName):
	var path=str("res://path/to/"+ sceneName +".tscn")
	get_tree().change_scene_to_file(path)
