ALL_POSTS = { 1 => { name: "1", content: "c1" }, 2 => { name: "2", content: "c2" } }
POST_ID = 2
CONTENT_POST_ID = { name: "2", content: "c2" }
NEW_ID = 3
A_NAME = "3"
ANOTHER_NAME = "4"
A_CONTENT = "c3"
ANOTHER_CONTENT = "c4"
NO_ID = ""
SAVE = "Save"
DELETE = "Delete"
CONTENT_NEW_ID = { name: A_NAME, content: A_CONTENT }
NEW_POST_ID = 1
FILE = File.expand_path(File.join(File.dirname(__FILE__), '../test_index.xml'))
ORIGINAL_FILE = File.read(FILE)
PORT = 8000
URI_INDEX_ADDRESS = "http://localhost:#{PORT}/"
URI_POST_ADDRESS = "http://localhost:#{PORT}/post"
