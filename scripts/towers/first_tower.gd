extends Node2D

@export var aggr_range: float = 3
@export var attack_damage: float = 10
@export var attack_speed: float = 1

@export var tower_id: String = ''
@export var body_id: String = ''
@export var module_id: String = ''

@export var type_tower: String = '1'  # Тип башни (1-6)

@export var max_health: float = 0
@export var self_health: float = 0

var enemy_in_range: Array = []
var target

func _ready() -> void:
	# Применяем статы из SmartTowers если есть tower_id и body_id
	if tower_id and body_id:
		SmartTowers.math_stats(self)
	
	z_index = global_position.y
	$Body/Range.scale *= aggr_range  # Исправлено!
	self_health = max_health
	$Attack.wait_time = attack_speed
	
	# Применяем тип башни
	apply_tower_type()

func apply_tower_type():
	match type_tower:
		'1':
			$Head.texture = load("res://textures/towers/towers_head.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 100.0
			attack_damage = 10.0
			attack_speed = 1.0
			max_health = 100.0
		'2':
			$Head.texture = load("res://textures/towers/towers_head_2.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 150.0
			attack_damage = 15.0
			attack_speed = 0.8
			max_health = 150.0
		'3':
			$Head.texture = load("res://textures/towers/towers_head_3.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'4':
			$Head.texture = load("res://textures/towers/towers_head_4.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'5':
			$Head.texture = load("res://textures/towers/towers_head_5.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'6':
			$Head.texture = load("res://textures/towers/towers_head_6.png")
			$Head.region_enabled = true
			$Head.region_rect = Rect2(0, 0, 32, 32)
			aggr_range = 500.0
			attack_damage = 20.0
			attack_speed = 3.0
			max_health = 200.0
		_:
			# Если тип не распознан, удаляем башню
			queue_free()

func _process(_delta: float) -> void:
	if len(enemy_in_range) != 0:
		target = enemy_in_range[0]
		rotate_head()
		if $Attack.is_stopped():
			$Attack.start(attack_speed)
	else:
		$Attack.stop()

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.append(body)      

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)

func rotate_head():
	var dir = target.global_position - global_position
	var angle_rad = dir.angle()
	var angle_deg = rad_to_deg(angle_rad)
	
	if 112.5 < angle_deg and angle_deg <= 157.5:
		$Head.region_rect.position.x = 0
	if (-157.5 <= angle_deg and angle_deg <= -180) or (157.5 < angle_deg and angle_deg <= 180):
		$Head.region_rect.position.x = 32
	if -157.5 < angle_deg and angle_deg <= -112.5:
		$Head.region_rect.position.x = 64
	if -112.5 < angle_deg and angle_deg <= -67.5:
		$Head.region_rect.position.x = 96
	if -67.5 < angle_deg and angle_deg <= -22.5:
		$Head.region_rect.position.x = 128
	if -22.5 < angle_deg and angle_deg <= 22.5:
		$Head.region_rect.position.x = 160
	if 22.5 < angle_deg and angle_deg <= 67.5:
		$Head.region_rect.position.x = 192
	if 67.5 < angle_deg and angle_deg <= 112.5:
		$Head.region_rect.position.x = 224

func _on_attack_timeout() -> void:
	target.self_health -= attack_damage
	if enemy_in_range and tower_id and body_id:
		SmartTowers.attack(self, target)
		SmartTowers.attack_anim(self, $Head)
	var shoot_anim = create_tween()
	var head_pos = $Head.position
	match $Head.region_rect.position.x:
		0.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x+2, head_pos.y-1), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		32.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x+3, head_pos.y), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		64.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x+2, head_pos.y+1), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		96.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x, head_pos.y+3), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		128.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x-2, head_pos.y+1), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		160.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x-3, head_pos.y), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		192.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x-2, head_pos.y-1), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
		224.0:
			shoot_anim.tween_property($Head, "position", Vector2(head_pos.x, head_pos.y-3), .1)
			shoot_anim.tween_property($Head, "position", head_pos, .2)
