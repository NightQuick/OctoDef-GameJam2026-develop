extends Node

var towers: Dictionary = {
	"watercannon": {
		"sprite": Vector2i(0, 1),
		"name": "Водомет",
		"discription": "Средняя скорость атаки, средний урон"
	},
	"bubblegun": {
		"sprite": Vector2i(1, 1),
		"name": "Пузырькомет",
		"discription": "Высокая скорость атаки, низкий урон"
	},
	"whirlpool": {
		"sprite": Vector2i(1, 1),
		"name": "Водоворот",
		"discription": "Низкая скорость атаки, средний урон, немного замедляет врагов"
	}
}

var bodies: Dictionary = {
	"base": {
		"sprite": Vector2i(0, 2),
		"name": "База",
		"discription": "Средняя прочность, средний радиус атаки"
	},
	"castle": {
		"sprite": Vector2i(1, 2),
		"name": "Крепость",
		"discription": "Высокая прочность, низкий радиус атаки, пониженная скорость атаки"
	},
	"ram": {
		"sprite": Vector2i(2, 2),
		"name": "Таран",
		"discription": "Низкая прочность, средний радиус атаки, увеличенная скорость атаки"
	},
	"arsenal": {
		"sprite": Vector2i(0, 2),
		"name": "Арсенал",
		"discription": "Средняя прочность, средний радиус атаки, увеличенный урон"
	}
}

var modules: Dictionary = {}
