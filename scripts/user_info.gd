extends Node
static var COLLECTION_ID = "user_info"

static func addCollection(data : Dictionary):
		var auth = Firebase.Auth.auth
		var username = ""
		if auth.localid:
			var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
			data = {
				"username" = username
			}
			var document = await collection.add(COLLECTION_ID, data)
