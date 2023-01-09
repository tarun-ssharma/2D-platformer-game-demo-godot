extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var coins = 0;
const MAX_COINS = 7;

# Called when the node enters the scene tree for the first time.
func _ready():
	#make sure the initial score is 0
	#it has to be a string here, cant be a number
	$Label_score.text = String(coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	$Label_score.text = String(coins)


func _physics_process(delta):
	pass

func _on_coin_collected():
	coins += 1;
	_ready();
	if coins == MAX_COINS:
		get_tree().change_scene("res://YouWin.tscn");
