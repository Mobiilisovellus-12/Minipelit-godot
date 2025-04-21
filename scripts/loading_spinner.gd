extends Node

static func loading():
	var spinner = Label.new()
	spinner.text = "🔄"
	spinner.name = "Spinner"
	spinner.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	spinner.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	
