extends Control

@onready var resolution_dropbox: OptionButton = find_child("ResolutionDropBox", true, false)
@onready var VSyncCheckBox = find_child("VSyncCheckBox", true, false)
@onready var VolumeSlider = find_child("VolumeSlider", true, false) 
@onready var VolumePrecentage = find_child("VolumePrecentage", true, false) 

func _ready() -> void:
	load_settings()
	VolumePrecentage.text = (str(int(VolumeSlider.value)) + '%')
	for currentResolution in Constants.listResolutions:
		resolution_dropbox.add_item(currentResolution)

func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		# Загружаем разрешение
		var resolution = config.get_value("video", "resolution", "")
		if resolution != "":
			# Правильный способ найти индекс по тексту
			for i in range(resolution_dropbox.item_count):
				if resolution_dropbox.get_item_text(i) == resolution:
					resolution_dropbox.select(i)
					change_resolution(resolution)
					break
		
		# Загружаем VSync
		var vsync = config.get_value("video", "vsync", true)
		VSyncCheckBox.button_pressed = vsync
		_on_v_sync_check_box_toggled(vsync)
		
		# Загружаем громкость
		var volume = config.get_value("audio", "volume", 50.0)
		VolumeSlider.value = volume
		_on_volume_slider_value_changed(volume)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("video", "resolution", resolution_dropbox.get_item_text(resolution_dropbox.selected))
	config.set_value("video", "vsync", VSyncCheckBox.button_pressed)
	config.set_value("audio", "volume", VolumeSlider.value)
	config.save("user://settings.cfg")

func change_resolution(resolution):
	var resolutionToChange = resolution.split('x')
	if resolutionToChange.size() != 2:
		return
	var width = float(resolutionToChange[0]) / 1920
	var height = float(resolutionToChange[1]) / 1080
	self.scale = Vector2(width, height)

func _on_resolution_drop_box_item_selected(index: int) -> void:
	var resolution = resolution_dropbox.get_item_text(index)
	change_resolution(resolution)
	save_settings()

func _on_v_sync_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		VSyncCheckBox.text = "Вкл."
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		VSyncCheckBox.text = "Выкл."
	save_settings()

func _on_volume_slider_value_changed(value: float) -> void:
	VolumePrecentage.text = (str(int(value)) + '%')
	save_settings()

func _on_exit_button_pressed() -> void:
	save_settings()
	get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
