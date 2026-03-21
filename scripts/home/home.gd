extends Node2D

@onready var buildingList:Dictionary={
	$bichFactory:[$bichFactory/bichFactoryArea,'bich'],
	$townHall:[$townHall/towenHallArea,'lab'],
	$mine:[$mine/mineArea,'min'],
	$detailFactory:[$detailFactory/detailFactoryArea,'det'],
	$constructionFactory:[$constructionFactory/constructionFactoryArea,'con'],
	$laboratory:[$laboratory/laboratoryArea,'lab']
}
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		$Camera2D.zoomChange(true)
	elif Input.is_action_just_pressed("scroll_down"):
		$Camera2D.zoomChange(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask==1:
		$Camera2D.moveCamera(event.relative.x,event.relative.y)

func _on_ready() -> void:
	
	for building in buildingList:
		buildingList[building][0].input_event.connect(_on_building_input_event.bind(building))

func _on_building_input_event(viewport: Node, event: InputEvent, shape_idx: int,building) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		FactoryGlobal.factoryType=buildingList[building][1]
		get_tree().change_scene_to_file("res://global_scenes/home/factory.tscn")
