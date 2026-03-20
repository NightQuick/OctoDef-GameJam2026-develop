extends CanvasLayer
@onready var listPosition= preload("res://nodes_scenes/interface/resourceNode.tscn")
@onready var lists: Dictionary={
	$towerOpener:[$towerList,false],
	$resourceOpener:[$resourceList,false]
}


func _on_listOpener_pressed(button) -> void:
	if lists[button][1]:
		lists[button][0].size.y=0
		lists[button][1]=false
		print("свернули список")
	else: 
		lists[button][0].size.y=500
		lists[button][1]=true
		print("Развернули список ",lists[button][0].size.y)
	


func _on_ready() -> void:
	for i in range(0,20):
		addPositionToList('Тест Ресурс','',$resourceList/VBoxContainer)
		addPositionToList('Тест Башня','',$towerList/VBoxContainer)
	for button in lists:
		button.pressed.connect(_on_listOpener_pressed.bind(button))

		


func _on_resourse_pressed(event: InputEvent,text) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print(text)

func addPositionToList(text,img,appendTo):
	var newPosition= listPosition.instantiate()
	newPosition.get_child(0).text= text
	newPosition.gui_input.connect(_on_resourse_pressed.bind(text))
	appendTo.add_child(newPosition)
