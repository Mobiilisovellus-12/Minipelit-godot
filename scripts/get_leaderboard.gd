extends Node

static func first_score(userName, highScore):
	var firestore = Firebase.Firestore.collection("Leaderboard")
	
	var data: Dictionary = {
		"name": userName,
		"score": highScore
	}
	
	var document = await firestore.add(userName, data)
	print(document)



#static func update_score(userName, highScore):
#	var firestore = Firebase.Firestore.collection("Leaderboard")
#	
#	var data := {
#		#"name": userName,
#		"score": highScore
#	}
#	
#	var document = await firestore.update(data)
#	print(document)


#this function reads all the documents from the Leaderboard collection and sorts them by score
static func read_and_sort_leaderboard():
	var query := FirestoreQuery.new()
	query.from("Leaderboard")
	
	var results = await Firebase.Firestore.query(query)
	
	if results == null:
		printerr("Query failed")
		printerr(results)
		return
		
	var scores = []
	for doc in results:
		scores.append({
			"name": doc.get("name"),
			"score": doc.get("score")
		})
	
	scores.sort_custom(func(a, b):
		return int(a["score"]) > int(b["score"])
	)
	
	for i in range(min(5, scores.size())): #5 = top 5 leaderboard. Change at your own will
		var entry = scores[i]
		print("#", i + 1, " Name: ", entry["name"], " | Score: ", entry["score"])
