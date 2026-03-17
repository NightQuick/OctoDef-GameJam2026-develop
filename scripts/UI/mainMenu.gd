extends Node2D

func _on_ready() -> void:
	pass
	
func _input(event): if event is InputEventMouseMotion:
	var relative= event.relative
	$Parallax.moveParallax($Parallax,relative.x,0.5,'x')


func _on_settings_button_pressed() -> void:
	changeScene('settingsScene')

func changeScene(sceneName):
	var path=str("res://global_scenes/UI/"+ sceneName +".tscn")
	print(path)
	get_tree().change_scene_to_file(path)

func _on_achivements_button_pressed() -> void:
	changeScene('achivementsScene')


func _on_exit_button_pressed() -> void:
	quitGame()

func quitGame():
	get_tree().quit()
