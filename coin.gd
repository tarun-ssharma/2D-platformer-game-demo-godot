extends Area2D

signal coin_collected
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_body_entered(body):
	#instead of checking the body type, we added collision layers and masks
	#so we know what can collide with this
	$AnimationPlayer.play("bounce");
	emit_signal("coin_collected");
	set_collision_mask_bit(0, false);
	#body.add_coin(); we want to add this logic to the label itself
	#queue_free() # delete this object, free the object from memory
	$CoinCollected.play();


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
