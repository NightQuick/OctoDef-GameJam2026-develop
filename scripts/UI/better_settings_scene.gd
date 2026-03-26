extends Control

@onready var resolution_dropbox: OptionButton = find_child("ResolutionDropBox", true, false)
@onready var VSyncCheckBox = find_child("VSyncCheckBox", true, false)
@onready var VolumeSlider = find_child("VolumeSlider", true, false) 
@onready var VolumePrecentage = find_child("VolumePrecentage", true, false) 


func _ready() -> void:
	VolumePrecentage.text = (str(int(VolumeSlider.value)) + '%')
	for currentResolution in Constants.listResolutions:
		resolution_dropbox.add_item(currentResolution)
	

func change_resolution(resolution):
	
	var resolutionToChange=resolution.split('x')
	var width = float(resolutionToChange[0])/1920
	var height = float(resolutionToChange[1])/1080
	
	self.scale=Vector2(width,height)

func _on_resolution_drop_box_item_selected(index: int) -> void:
	var resolution = resolution_dropbox.get_item_text(index)
	change_resolution(resolution)

func _on_v_sync_check_box_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_vsync_mode(int(toggled_on))
	match toggled_on:
		true:VSyncCheckBox.text = "Вкл."
		false:VSyncCheckBox.text = "Выкл."

func _on_volume_slider_value_changed(value: float) -> void:
	VolumePrecentage.text = (str(int(value)) + '%')

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
