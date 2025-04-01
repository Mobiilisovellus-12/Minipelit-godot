extends Node

static func read_json(filePath : String):
	if FileAccess.file_exists(filePath):
		
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedRes = JSON.parse_string(dataFile.get_as_text())
		
		if parsedRes is Dictionary:
			return parsedRes
		else:
			print("Can't read file")
	
	else:
		print("Doesn't exist")
