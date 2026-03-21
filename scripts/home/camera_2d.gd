extends Camera2D
@onready var camera: Camera2D = $"."

func moveCamera(x,y):
	var oldPosition=camera.position
	camera.position=Vector2(oldPosition.x-x,oldPosition.y-y)

func zoomChange(zoomType):
	var currentZoom=camera.zoom
	var x=float('%.1f' % currentZoom.x)
	print(currentZoom)
	print(x)
	if zoomType && x<8:
		camera.zoom=Vector2(currentZoom.x+0.2,currentZoom.y+0.2)
	elif !zoomType && x>=1.1:
		camera.zoom=Vector2(currentZoom.x-0.2,currentZoom.y-0.2)
