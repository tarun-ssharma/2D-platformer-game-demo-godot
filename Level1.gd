extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("toggle_fullscreen"):
		if OS.window_fullscreen:
			OS.window_fullscreen = false;
			OS.set_window_size(Vector2(1024, 600));
		else:
			OS.window_fullscreen = true;
