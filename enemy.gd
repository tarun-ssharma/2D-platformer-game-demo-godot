extends KinematicBody2D

var velocity = Vector2();
# direction: 1 for right anf -1 for left (in which direction its
# going to go next
export var direction = -1; 
var VEL = 50;
export var detect_cliffs = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true;
	else:
		$AnimatedSprite.flip_h = false;
	$"floor checker".position.x = (direction)*$CollisionShape2D.shape.get_extents().x
	$"floor checker".enabled = detect_cliffs;
	if detect_cliffs:
		set_modulate(Color(1.0, 1.0, 0.3, 0.4))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	# check by what parameters to change the velocity
	if is_on_wall() or (detect_cliffs and not $"floor checker".is_colliding() and is_on_floor()):
		direction = -direction;
		_ready();
	
	# change velocity
	## SIMULATING GRAVITY
	velocity.y += 20;
	velocity.x = direction*VEL;
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("squashed");
	VEL = 0;
	set_collision_mask_bit(0, false);
	$top_checker.set_collision_mask_bit(0, false)
	$side_checker.set_collision_mask_bit(0, false)
	$Timer.start();
	body.jump_a_little();
	$GettingSquished.play();


func _on_side_checker_body_entered(body):
	#set color
	body.ouch(position.x > body.position.x);
	# we disable possible collision with player once hes dead
	# remove this if you want multiple lives for the main character
	$top_checker.set_collision_mask_bit(0, false)
	$side_checker.set_collision_mask_bit(0, false)
	#get_tree().change_scene("res://Level1.tscn")


func _on_Timer_timeout():
	queue_free();
