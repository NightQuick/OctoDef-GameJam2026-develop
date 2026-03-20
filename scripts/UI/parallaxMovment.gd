extends Node

func moveParallax(parallaxNode,changeValue,ratio,coordType=['x','y']):
	var currentPosition = parallaxNode.screen_offset
#	Проверка валидности данных
	if (coordType is Array && changeValue is float||coordType is String&& (changeValue is Vector2||changeValue is Array)):
		printerr('moveParallax func:incorrect data type, check input data')
#	Проерка того, какой тип данных имеет changeValue
	if(changeValue is Vector2 || changeValue is float):
		changeValue=changeValue*ratio
		
	if(changeValue is Array):
		for i in range(changeValue.length):
			changeValue[i]=changeValue[i]*ratio
		
	
#	Присвоение параллаксу значения
	if(coordType is Array):
		currentPosition.x+=changeValue[0]
		currentPosition.y+=changeValue[1]
		parallaxNode.screen_offset=currentPosition
	elif (coordType=='x'):
<<<<<<< HEAD
		
=======
		print(changeValue)
>>>>>>> 280ba808ccbe6f55b3712603ee82596c0c9aae66
		currentPosition.x+=changeValue
		parallaxNode.screen_offset=currentPosition
	elif (coordType=='y'):
		currentPosition.y+=changeValue
		parallaxNode.screen_offset=currentPosition
