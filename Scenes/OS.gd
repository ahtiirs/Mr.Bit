extends KinematicBody2D


const MOTION_SPEED = 90# Pixels/second.
const maxSpeed = 1

var acceleration = 200 # mängija kiirendus ja pidurdus
var motion = Vector2.ZERO 
var collided = false # kui pole seinaga kokkupõrget toimunud siis alväärtus on false
var MaxDistance = 500 # max kaugus millest lähemal vaenlane märkab mängijat
var  FOV = 90 # vaenlase vaatenurk
var freeDistance = []
var time_start = 0
var time_now = 0
var walk = false

var moves = {
	1 : Vector2(-1,1),
	2 : Vector2(0,1),
	3 : Vector2(1,1),
	4 : Vector2(1,0),
	5 : Vector2(1,-1),
	6 : Vector2(0,-1),
	7 : Vector2(-1,-1),
	8 : Vector2(-1,0),
	9 : Vector2(0,0)
}
var moveVector = Vector2(1,1)
var newVector = 0
var rng = RandomNumberGenerator.new()


	
onready var EnemyToPlayer = global_position

onready var EnemyPosition = get_parent().get_node("Player").get_position()
var timer = 0
var tryTime = 0
var randMouse = 0
var randEnemy = 0

enum {
	IDLE,
	WANDER,
	CHASE
}



func _ready():
	rng.randomize()
	pass

func update_target_position():

	if timer <= 0 || collided == true && tryTime <= 0:


		randMouse = int(get_viewport().get_mouse_position().x + get_viewport().get_mouse_position().y)
		randEnemy = int(EnemyPosition.x + EnemyPosition.y)
		newVector = (rng.randi() + randMouse + randEnemy) % 9 + 1
		moveVector = moves[newVector]
	
		for i in range(1, 9):
#			print("Accessing item at index " + str(i))
#			print(moves[i])
			var freeWay = checkForCollision(moves[i]*500) - global_position
			freeDistance.append(freeWay)
#			print("kaugus ",freeWay)
#			print(checkForCollision(moves[i]*500))
			i+=1
	
		
		timer = (randi() % 5) +4
		collided = false
		pass
		




#		newVector = randi() % 8
#		var randomAngle =  newVector * PI / 8
#		print("random: ", randomAngle)
#		timer = (randi() % 8) 
#
#
#		moveVector = moveVector.rotated(randomAngle)
##		moveVector = Vector2((randi() % 100) - 100, (randi() % 100) - 100)
#
##		checkForCollision(moveVector*250)
#		while checkForCollision(moveVector*250):
#			moveVector = moveVector.rotated(randomAngle)
#			print("vaatevektor ",moveVector*500)
#		collided = false
#		print(moveVector*250)

func checkForCollision(position):
	get_node("RayCast2D").position = Vector2(0,0)
	get_node("RayCast2D").cast_to = position# sets the length of the ray to 0
	get_node("RayCast2D").add_exception(self)
	get_node("RayCast2D").force_raycast_update()
#	print("Raycast...",$RayCast2D.is_colliding())
#	print("Raycast...", $RayCast2D.get_collider ())
	$RayCast2D.get_collision_point()
	return $RayCast2D.get_collision_point ()

func round_dir(vector):
	if vector <= -0.5:
		return -1
	if vector < 0.5:
		return 0
	if vector <= 1:
		return 1

func _process(delta):
	if timer > 0:
		timer -= delta
	if tryTime > 0:
		tryTime -= delta
		

		
	
	EnemyToPlayer = global_position - EnemyPosition

	motion += moveVector * acceleration * delta 

	if (moveVector.x == 0):
		motion.x = lerp(0,motion.x, pow(2,  -20 * delta))
	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -20 * delta))
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)

	if !walk:
		motion = Vector2(0,0)

	var collision = move_and_collide(motion)


#	print(collision)
#	print(collided)
	
	
	if collision :
#		if collision.Object != null :
#			if collided == false:
#			print("vastu seina")
			update_target_position()
			collided = true
			tryTime= 0
#	else:
#		collided = false
				
	
	update_target_position()		


	update_animation(moveVector)

	

	


func update_animation(moveVec):

#	print ("valvur ",moveVec)
	if (moveVec.x < 0 && moveVec.y > 0):
		$AnimatedSprite.play("1")
	if (moveVec.x == 0 && moveVec.y > 0 ):
		$AnimatedSprite.play("2")
	if (moveVec.x > 0 && moveVec.y  > 0):
		$AnimatedSprite.play("3")		
	if (moveVec.x > 0 && moveVec.y == 0):
		$AnimatedSprite.play("4")			
	if (moveVec.x  > 0&& moveVec.y < 0):
		$AnimatedSprite.play("5")
	if (moveVec.x == 0 && moveVec.y < 0):
		$AnimatedSprite.play("6")		
	if (moveVec.x < 0 && moveVec.y < 0):
		$AnimatedSprite.play("7")
	if (moveVec.x < 0 && moveVec.y == 0):
		$AnimatedSprite.play("8")		
	if (moveVec.x == 0 && moveVec.y == 0):
		$AnimatedSprite.play("idle")
		
