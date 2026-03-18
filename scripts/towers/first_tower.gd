extends Node2D

@export var aggr_range: float = 1
@export var attack_damage: float = 1
@export var attack_speed: float = 1 

var enemy_in_range: Array = []

func _ready() -> void:
	$Body/Range.scale = $Body/Range.scale*aggr_range

func _process(_delta: float) -> void:
	if len(enemy_in_range) != 0:
		rotate_head(enemy_in_range)

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.append(body)

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)

func rotate_head(bodies: Array):
	#Пока что тут настройка поворота на первого врага, что вошёл в зону поражения башни
	var dir = bodies[0].global_position - global_position
	var angle_rad = dir.angle()
	var angle_deg = rad_to_deg(angle_rad)
	
	if 112.5 < angle_deg and angle_deg <= 157.5:
		$Head.region_rect = Rect2(0, 0, 32, 32)
	if (-157.5 <= angle_deg and angle_deg <= -180) or (157.5 < angle_deg and angle_deg <= 180):
		$Head.region_rect = Rect2(32, 0, 32, 32)
	if -157.5 < angle_deg and angle_deg <= -112.5:
		$Head.region_rect = Rect2(64, 0, 32, 32)
	if -112.5 < angle_deg and angle_deg <= -67.5:
		$Head.region_rect = Rect2(96, 0, 32, 32)
	if -67.5 < angle_deg and angle_deg <= -22.5:
		$Head.region_rect = Rect2(128, 0, 32, 32)
	if -22.5 < angle_deg and angle_deg <= 22.5:
		$Head.region_rect = Rect2(160, 0, 32, 32)
	if 22.5 < angle_deg and angle_deg <= 67.5:
		$Head.region_rect = Rect2(192, 0, 32, 32)
	if 67.5 < angle_deg and angle_deg <= 112.5:
		$Head.region_rect = Rect2(224, 0, 32, 32)
	
