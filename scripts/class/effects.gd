class_name Effects

static func effect(Body: Node):
	if Body.effects.has("slow"):
		slow(Body, Body.effects["slow"][0], Body.effects["slow"][1])

static func slow(Body: Node, dur: float, strn: int):
	Body.self_speed = Body.self_speed_before - strn
	await Body.get_tree().create_timer(dur).timeout
	if Body:
		Body.effects.erase('slow')
		Body.self_speed = Body.self_speed_before
