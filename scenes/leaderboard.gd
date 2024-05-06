extends Control
@onready var leaderboard = $LeaderboardVContainer/LeaderboardTree
@onready var actual_score_tree = $LeaderboardVContainer/ActualScoreTree
@onready var record_label = $LeaderboardVContainer/RecordLabel
var new_record = false
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Username: "+Global.username+" Score: "+str(Global.score))
	$HTTPRequest.request_completed.connect(_on_request_completed)
	var json = JSON.stringify({"username": Global.username, "high_score": Global.score})
	var headers = ["Content-Type: application/json"]
	$HTTPRequest.request(Global.api_url, headers, HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	#print(json)
	new_record = json["body"]["new_record"]
	fill_leaderboard(json["body"]["Items"])


func _on_close_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func fill_leaderboard(records_arr: Array) -> void:
	var ast_root = actual_score_tree.create_item()
	ast_root.set_text(0, Global.username)
	ast_root.set_text(1, str(Global.score))
	
	var root = leaderboard.create_item()
	root.set_text(0, "Rank")
	root.set_text(1, "Username")
	root.set_text(2, "Score")
	root.set_text(3, "Scored On")
	var sorted_arr = ranking_sorting(records_arr)
	for i in range(len(records_arr)):
		var row = leaderboard.create_item(root)
		row.set_text(0, str(i+1))
		row.set_text(1, sorted_arr[i]["username"])
		row.set_text(2, str(sorted_arr[i]["high_score"]))
		row.set_text(3, sorted_arr[i]["score_date"])
	if(new_record):
		record_label.text = "[img={48}x{48}]res://assets/crown24.png[/img][color=yellow]  [b]NEW RECORD!!![/b][/color]"
	else:
		record_label.text = "  [color=yellow]  [b]Current Score[/b][/color]"
		

#funion para acomodar por fecha ascendente 
func ranking_sorting(my_arr: Array) -> Array:
	for i in range(my_arr.size()):
		if(i+1 < my_arr.size()):
			var a = my_arr[i]
			var b = my_arr[i+1]
			if(a["high_score"] == b["high_score"] and a["score_date"].naturalnocasecmp_to(b["score_date"])>0):
				my_arr[i+1] = a
				my_arr[i] = b
	return my_arr
