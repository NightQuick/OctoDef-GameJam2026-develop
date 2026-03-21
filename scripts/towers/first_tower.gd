extends Node2D

@export var aggr_range: float = 1
@export var attack_damage: float = 1
@export var attack_speed: float = 1 #МАКСИМАЛЬНАЯ СКОРОСТЬ АТАКИ 0.3... иначе анимащия сдохнет

var enemy_in_range: Array = []
var target

func _ready() -> void:
	z_index = global_position.y
	$Body/Range.scale = $Body/Range.scale*aggr_range
	$Attack.wait_time = attack_speed

func _process(_delta: float) -> void:
	if len(enemy_in_range) != 0:
		
		#В этой башне, цель настроена на первого вошедшего в зону поражения врага
		target = enemy_in_range[0]
		
		rotate_head()
		if $Attack.is_stopped(): $Attack.start(attack_speed)
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
