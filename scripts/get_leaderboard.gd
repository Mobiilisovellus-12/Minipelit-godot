extends Node

static func get_leaderboard_from_firebase() -> void:
	var auth = Firebase.Auth.auth
	
	if auth.has("localid"):
		var local_id = auth["localid"]
		
		var collection: FirestoreCollection = Firebase.Firestore.collection("Leaderboard")
		var task = await collection.get_doc(local_id)
		
		var document = task.document
		
		if document != null:
			print("📄 Leaderboard Entry for", local_id)
			print("Username:", document.get("username", "Unknown"))
			print("Score:", document.get("score", 0))
		else:
			print("No leaderboard entry found for user:", local_id)
	else:
		print("User is not authenticated.")
