extends KinematicBody2D

var velocity = Vector2(0,0)
const SPEED = 250
const GRAVITY = 35
const JUMPFORCE = -1100

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)
	
	if not is_on_floor():
		$Sprite.play("air")
		

func _on_Fall_Zone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")


func _on_coin_collected():
	pass # Replace with function body.
	
func bounce():
	velocity.y = 0.7 * JUMPFORCE

func ouch(var enemy_x):
	set_modulate(Color(1, 0.3, 0.3, 0.3))
	velocity.y = 0.5 * JUMPFORCE
	if position.x < enemy_x:
		velocity.x = -800
	elif position.x > enemy_x:
		velocity.x = 800	
	
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn")
