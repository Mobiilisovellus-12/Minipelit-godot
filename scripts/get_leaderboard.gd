extends Node

#adds or updates a document in leaderboard collection based on localid
static func add_or_update(userName, highScore):
	var data: Dictionary = {
		"name": userName,
		"score": highScore
	}
	
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection("Leaderboard")
		var task = await collection.get_doc(auth.localid)
		if task:
			await collection.update(FirestoreDocument.new(data))
		else:
			await collection.add(auth.localid, data)



#this function reads all the documents from the Leaderboard collection and sorts them by score
static func read_and_sort_leaderboard(Vcontainer):
	var query := FirestoreQuery.new()
	query.from("Leaderboard")
	
	var results = await Firebase.Firestore.query(query)
	
	if results == null:
		printerr("Query failed")
		return
		
	var scores = []
	for doc in results:
		var name = doc.get("name")
		var score = doc.get("score")
		if typeof(score) != TYPE_INT:
			score = int(str(score))
		scores.append({
			"name": name,
			"score": score
		})
	
	scores.sort_custom(func(a, b):
		return a["score"] > b["score"]
	)
	
	for i in range(min(5, scores.size())): #5 = top 5 leaderboard. Change at your own will
		var entry = scores[i]
		
		var label = Label.new()
		
		label.text = "#%d | User: %s | Score: %d" % [i + 1, entry["name"], entry["score"]]
		
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		
		label.add_theme_font_size_override("font_size", 30)
		
		var row_spacer = Control.new()
		row_spacer.custom_minimum_size = Vector2(0, 30)
		
		Vcontainer.add_child(label)
		Vcontainer.add_child(row_spacer)
