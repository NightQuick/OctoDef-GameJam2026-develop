extends Node2D

func _input(event): if event is InputEventMouseMotion:
	var relative= event.relative
	$Parallax.moveParallax($Parallax,relative.x,0.5,'x')
