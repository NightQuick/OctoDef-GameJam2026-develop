extends "res://scripts/towers/first_tower.gd"

@export var tower_id: String = ''
@export var body_id: String = ''
@export var module_id: String = ''

@onready var type_tower : String

@export var max_health: float = 0
@export var self_health: float = 0

func _ready() -> void:
	if tower_id and body_id:
		SmartTowers.math_stats(self)
	z_index = global_position.y
	$Body/Range.scale *= aggr_range
	self_health = max_health
	$Attack.wait_time = attack_speed
	
	match type_tower:
		_:
			queue_free()
		
		'1':
			$Head.texture = load("res://textures/towers/towers_head.png")
			aggr_range = 100.0
			attack_damage = 10.0
			attack_speed = 1.0
			max_health = 100.0
		'2':
			$Head.texture = load("res://textures/towers/towers_head_2.png")
			aggr_range = 150.0
			attack_damage = 15.0
			attack_speed = 0.8
			max_health = 150.0
		'3':
			$Head.texture = load("res://textures/towers/towers_head_3.png")
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'4':
			$Head.texture = load("res://textures/towers/towers_head_4.png")
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'5':
			$Head.texture = load("res://textures/towers/towers_head_5.png")
			aggr_range = 200.0
			attack_damage = 20.0
			attack_speed = 0.6
			max_health = 200.0
		'6':
			$Head.texture = load("res://textures/towers/towers_head_6.png")
			aggr_range = 500.0
			attack_damage = 20.0
			attack_speed = 3 
			max_health = 200.0

func _physics_process(_delta: float) -> void:
	if enemy_in_range and tower_id and body_id:
		target = SmartTowers.select_target(self)
		SmartTowers.rotate_head(self, target, $Head)

func _on_body_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.append(body)

func _on_body_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemy_in_range.erase(body)

func _on_attack_timeout() -> void:
	if enemy_in_range and tower_id and body_id:
		SmartTowers.attack(self, target)
		SmartTowers.attack_anim(self, $Head)
