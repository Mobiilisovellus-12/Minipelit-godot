extends Node

static func first_score(userName, highScore) -> void:
	var firestore = Firebase.Firestore.collection("Leaderboard")
	
	var data := {
		"name": userName,
		"score": highScore
	}
	
	var document = await firestore.add(userName, data)
	print(document)



static func update_score(userName, highScore):
	var firestore = Firebase.Firestore.collection("Leaderboard")
	
	var data := {
		#"name": userName,
		"score": highScore
	}
	
	var document = await firestore.update(data)
	print(document)


static func read_and_sort_leaderboard():
	var query: FirestoreQuery = FirestoreQuery.new().from("Leaderboard").where("score", FirestoreQuery.OPERATOR.GREATER_THAN, 1).order_by("score", FirestoreQuery.DIRECTION.DESCENDING).limit(10)
	
	var results = await Firebase.Firestore.query(query)
