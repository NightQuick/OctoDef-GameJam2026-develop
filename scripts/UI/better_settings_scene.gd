# scripts/UI/better_settings_scene.gd
extends Control

@onready var resolution_dropbox: OptionButton = find_child("ResolutionDropBox", true, false)
@onready var vsync_check_box = find_child("VSyncCheckBox", true, false)
@onready var volume_slider = find_child("VolumeSlider", true, false)
@onready var volume_percentage = find_child("VolumePrecentage", true, false)

func _ready() -> void:
	load_settings()
	volume_percentage.text = str(int(volume_slider.value)) + '%'
	
	for resolution in Constants.listResolutions:
		resolution_dropbox.add_item(resolution)

func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") != OK:
		return
	
	# Загружаем разрешение
	var resolution = config.get_value("video", "resolution", "")
	if resolution != "":
		for i in range(resolution_dropbox.item_count):
			if resolution_dropbox.get_item_text(i) == resolution:
				resolution_dropbox.select(i)
				apply_resolution(resolution)
				break
	
	# Загружаем VSync
	var vsync = config.get_value("video", "vsync", true)
	vsync_check_box.button_pressed = vsync
	apply_vsync(vsync)
	
	# Загружаем громкость
	var volume = config.get_value("audio", "volume", 50.0)
	volume_slider.value = volume
	apply_volume(volume)

func save_settings():
	var config = ConfigFile.new()
	config.set_value("video", "resolution", resolution_dropbox.get_item_text(resolution_dropbox.selected))
	config.set_value("video", "vsync", vsync_check_box.button_pressed)
	config.set_value("audio", "volume", volume_slider.value)
	config.save("user://settings.cfg")

func apply_resolution(resolution):
	var resolution_parts = resolution.split('x')
	if resolution_parts.size() != 2:
		return
	
	var width = resolution_parts[0].to_int()
	var height = resolution_parts[1].to_int()
	
	# Применяем реальное разрешение окна
	get_window().size = Vector2i(width, height)

func apply_vsync(enabled: bool):
	if enabled:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		vsync_check_box.text = "Вкл."
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		vsync_check_box.text = "Выкл."

func apply_volume(value: float):
	volume_percentage.text = str(int(value)) + '%'
	# Здесь можно добавить изменение громкости глобального аудио

func _on_resolution_drop_box_item_selected(index: int) -> void:
	var resolution = resolution_dropbox.get_item_text(index)
	apply_resolution(resolution)
	save_settings()

func _on_v_sync_check_box_toggled(toggled_on: bool) -> void:
	apply_vsync(toggled_on)
	save_settings()

func _on_volume_slider_value_changed(value: float) -> void:
	apply_volume(value)
	save_settings()

func _on_exit_button_pressed() -> void:
	save_settings()
	get_tree().change_scene_to_file("res://global_scenes/UI/mainMenu.tscn")
