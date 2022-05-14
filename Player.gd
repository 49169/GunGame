extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dir = Vector2(0,0)
var thrust = Vector2(0,0)
var velocity = Vector2(0,0)

onready var bullet = preload("res://bullet.tscn")
var x = 0
var y = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	print("shoot")
	var dir = (position - get_global_mouse_position()).normalized()
	thrust = dir * 300
	#velocity += thrust
	
	var newBullet = bullet.instance()
	get_parent().add_child(newBullet)
	newBullet.position = position
	newBullet.dir = -dir 
	#newBullet.speed = velocity.length()
	pass
	
func _physics_process(delta):
	#thrust = thrust.move_toward(Vector2.ZERO, 25)
	#print(thrust)
	if is_on_floor() == false:
		velocity.y += 50
		#print("floating")
	else:
		#print("grounded")
		pass
	print(velocity.x)
	if x != 0:
		velocity.x = lerp(velocity.x, x * 500, 0.5)
		pass
	if velocity.x != 0 :
		velocity.x = move_toward(velocity.x, 0, 45)
		
	velocity = move_and_slide((Vector2(velocity.x,velocity.y)), Vector2.UP)
	#move_and_slide(thrust)
	
	#move_and_slide(Vector2(0,-1) * 980)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	x = 0
	y = 0
	if Input.is_action_pressed("ui_left"):
		x = -1
	if Input.is_action_pressed("ui_right"):
		x = 1
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			print("jump")
			y = -1
			velocity.y = y*700
			
	if Input.is_action_pressed("ui_down"):
		y = 1
	if Input.is_action_pressed("ui_accept"):
		if $Timer.time_left <= 0:
			$Timer.start(0.1)
			shoot()
	pass

