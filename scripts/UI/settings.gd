extends Node2D
@onready var resolution_dropbox: OptionButton = $settingsList/settingsChangers/resolutionDropbox


func _on_ready() -> void:
	for currentResolution in Constants.listResolutions:
		resolution_dropbox.add_item(currentResolution)
	
	

func change_resolution(resolution):
	
	var resolutionToChange=resolution.split('x')
	var width=float(resolutionToChange[0])/1920
	var height=float(resolutionToChange[1])/1080
	
	$".".scale=Vector2(width,height)


func _on_resolution_dropbox_item_selected(index: int) -> void:
	var resolution= resolution_dropbox.get_item_text(index)
	change_resolution(resolution)


func _on_v_sync_check_box_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_vsync_mode(int(toggled_on))
	match toggled_on:
		true:$settingsChangers/Vsync/VSyncCheckBox.text="Вкл."
		
		false:$settingsChangers/Vsync/VSyncCheckBox.text="Выкл."


func _on_volume_slider_value_changed(value: float) -> void:
	$settingsList/settingsLabels/volume/volumeLevel.text=str(int(value))+'%'


func _on_back_to_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
