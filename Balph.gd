extends KinematicBody2D


var velocity = Vector2(0,0)
const SPEED = 200
const JUMPFORCE = -1100
const GRAVITY = 30
var coins = 0
const MAX_COINS = 3

func jump_a_little():
	velocity.y = JUMPFORCE/3;

# this is the game loop, will be run 60 times per second
	# call the method print
	#pass
	
func _physics_process(delta):
	var speed = SPEED;
	if Input.is_action_pressed("action_speed"):
		speed *= 2;
	if Input.is_action_pressed("action_right"):
		velocity.x = speed
		$Sprite.play("walk");
		$Sprite.flip_h = false;
	elif Input.is_action_pressed("action_left"):
		velocity.x = -speed
		$Sprite.play("walk");
		$Sprite.flip_h = true;
	else:
		$Sprite.play("idle");
		
#	var up
#	if position.y < 256:
#		up = Vector2.UP
#	else:
#		up = Vector2.DOWN;
	if not is_on_floor():
		# since we are checking and setting sprite properties
		# here after above if-elses, 
		# if he's in air, he cant appear walking 
		# even if arrow keys are pressed
		$Sprite.play("air");
#		$Sprite.flip_h = false;
	# is_on_floor is built in function for a KinematicBody2D, so can be used directly
	if Input.is_action_just_pressed("action_jump") and is_on_floor():
		velocity.y = JUMPFORCE;
		$SoundJump.play();
	velocity.y += GRAVITY; # like gravity, keeps falling unless a collision happens
	
	# This method handles collision as well (Character stops moving when colliding with a Collision2D Object) but doesnt tell us that 
	# y motion has become 0, so we need to reset velocity ourself
	velocity = move_and_slide(velocity, Vector2.UP)
#	if velocity.y == 0:
#		print("body stopped!")
	
	## starts decreasing and if right/left arrows are pressed no more in subsequent game loop calls,
	## it keeps on decreasing.
	velocity.x = lerp(velocity.x, 0, 0.1)
	
#	if coins == MAX_COINS:
#		get_tree().change_scene("res://Level1.tscn")

#func add_coin ():
#	coins += 1;

func _on_fall_zone_body_entered(body):
	get_tree().change_scene("res://GameOver.tscn")

func ouch(var enemy_to_the_right):
	set_modulate(Color(1, 0.3, 0.3, 0.4));
	velocity.y = -800;
	var direction = 1;
	if enemy_to_the_right:
		direction = -1
	velocity.x = 800*(direction);
	## we disable any input that was pressed so we can see the player being startled
	Input.action_release("action_jump");
	Input.action_release("action_left");
	Input.action_release("action_right");
	Input.action_release("action_speed");
	$Timer.start();

func _on_Timer_timeout():
	get_tree().change_scene("res://GameOver.tscn");
