extends Node2D

@onready var buildingList:Dictionary={
	$bichFactoryArea/bichFactory:[$bichFactoryArea,'bich'],
	$townHallArea/townHall:[$townHallArea,'twn'],
	$mineArea/mine:[$mineArea,'min'],
	$detailFactoryArea/detailFactory:[$detailFactoryArea,'det'],
	$constructionFactoryArea/constructionFactory:[$constructionFactoryArea,'con'],
	$laboratoryArea/laboratory:[$laboratoryArea,'lab']
}
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("scroll_up"):
		$Camera2D.zoomChange(true)
	elif Input.is_action_just_pressed("scroll_down"):
		$Camera2D.zoomChange(false)
	if $Camera2D.zoom.x<1.2:
		$Parallax.screen_offset.x=0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and $Camera2D.zoom.x>=1.2:
		var relative= event.relative
		$Parallax.moveParallax($Parallax,relative.x,0.01,'x')
	if event is InputEventMouseMotion and event.button_mask==1:
		$Camera2D.moveCamera(event.relative.x,event.relative.y)

func _on_ready() -> void:
	for building in buildingList:
		print('привязываем ',building, ' к ',buildingList[building][0])
		buildingList[building][0].input_event.connect(_on_building_input_event.bind(building))
		buildingList[building][0].mouse_entered.connect(_on_building_hover.bind(building))
		buildingList[building][0].mouse_exited.connect(_on_building_blur.bind(building))

func _on_building_input_event(viewport: Node, event: InputEvent, shape_idx: int,building) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		
		FactoryGlobal.factoryType=buildingList[building][1]
		get_tree().change_scene_to_file("res://global_scenes/home/factory.tscn")

func _on_building_hover(building):
	building.visible=true

func _on_building_blur(building):
	building.visible=false

func _on_gate_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file("res://global_scenes/battlegrounds/level_1.tscn")

func _on_gate_area_mouse_entered() -> void:
	$gateArea/ActiveGate.visible=true

func _on_gate_area_mouse_exited() -> void:
	$gateArea/ActiveGate.visible=false
