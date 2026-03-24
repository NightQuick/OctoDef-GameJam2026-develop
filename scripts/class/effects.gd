class_name Effects

static func effect(Body: Node):
	duration(Body)
	if Body.effects.has("slow"):
		print("Эффект нашёлся: ",Body.effects)
		slow(Body)
	else: Body.self_speed = Body.self_speed_before

static func duration(Body: Node):
	var effects_keys = Body.effects.keys()
	for eff in effects_keys:
		Body.effects[eff][0] -= 1
		if Body.effects[eff][0] <= 0:
			Body.effects.erase(eff)
			print("очистился: ", eff)
	await Body.get_tree().create_timer(1.0).timeout

static func slow(Body: Node):
	Body.self_speed = Body.self_speed_before - Body.effects["slow"][1]
