extends Node2D
@onready var resolutionDropbox=$HBoxContainer/VBoxContainer2/resolutionDropbox

func _on_ready() -> void:
	for currentResolution in Constants.listResolutions:
		var currentResolutionText=str(currentResolution[0])+'x'+str(currentResolution[1])+" ("+str(currentResolution[2]+")")
		resolutionDropbox.get_popup().add_item(currentResolutionText)
	resolutionDropbox.get_popup().id_pressed.connect(_on_popup_menu_item_pressed)
	
func _on_popup_menu_item_pressed(id: int):
	var pressedText=resolutionDropbox.get_popup().get_item_text(id)
	resolutionDropbox.text=pressedText
	pressedText=pressedText.split(" ")
	pressedText=pressedText[0].split('x')
	var resolution=[int(pressedText[0]),int(pressedText[1])]
	
	var window = get_window()
	
	# ВАЖНО: Проверяем режим окна
	print("Текущий режим окна: ", window.mode)
	print("Полноэкранный режим? ", window.mode == Window.MODE_FULLSCREEN)
	
	change_resolution(resolution[0],resolution[1])

func change_resolution(width: int, height: int):
	# Получаем текущее окно
	var window = get_window()
	
	# Устанавливаем новый размер окна
	get_tree().root.content_scale_size=Vector2i(width,height)
	#window.content_scale_size = Vector2i(width, height)
	#get_viewport().size=Vector2i(width, height)
	
	print("Разрешение изменено на: ", width, "x", height)
