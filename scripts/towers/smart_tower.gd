extends Node2D

@export var tower_id: String = ''
@export var body_id: String = ''
@export var module_id: String = ''

@export var aggr_range: float = 0
@export var attack_damage: float = 0
@export var attack_speed: float = 0
@export var max_health: float = 0
@export var self_health: float = 0

var enemy_in_range: Array = []
var target

func _ready() -> void:
	if tower_id and body_id:
		SmartTowers.math_stats(self)
	z_index = global_position.y
	$Body/Range.scale *= aggr_range
	self_health = max_health
	$Attack.wait_time = attack_speed

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
