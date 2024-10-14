extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 10

#enemy health
var health = 100

@onready var nav_agent = $NavigationAgent3D
@onready var player = $"../Player"
var run_speed = 1

var enemy_in_range = false

var player_dead = false

signal enemy_hit
signal enemy_death

@export var ANIMATIONPLAYER : AnimationPlayer

# identifies global scene for storing variables between scenes
@onready var global = get_node("/root/Global")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var playerspotted = false

func _ready():
		ANIMATIONPLAYER.play("global/enemyrotate")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Enemy is delted when health is equal or lesser than 0
	if health <= 0:
		emit_signal("enemy_death")
		global.money += 5
		print("money=", global.money)
	
	if playerspotted == true and player_dead == false:
		if not is_on_floor():
			velocity.y -= gravity * delta
			print("floating")
		
		look_at(player.global_position)
		rotation.x = clamp(rotation.x, 0, 0)
		var current_location = global_transform.origin
		print("current_location = ", current_location)
		var next_location = nav_agent.get_next_path_position()
		print("next location = ", next_location)
		var new_velocity = (next_location - current_location).normalized()*SPEED
		print ("new_velocity = ", new_velocity)
		velocity = velocity.move_toward(new_velocity, 2000)
		print("velocity = ", velocity)
		
	elif playerspotted == false and player_dead == false:
		velocity = Vector3.ZERO
		get_tree().create_timer(1.0).timeout
	else:
		pass
	
	move_and_slide()
	
	
	#check for if enemy can hit player
	
	

func _on_vision_timer_timeout():
	var overlaps = $VisionCone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.is_in_group("player"):
				var playerposition = overlap.global_transform.origin
				$VisionRaycast.look_at(playerposition, Vector3.UP)
				$VisionRaycast.force_raycast_update()
				
				if $VisionRaycast.is_colliding():
					var collider = $VisionRaycast.get_collider()
					
					if collider.is_in_group("player"):
						if not playerspotted:
							ANIMATIONPLAYER.play("global/RESET")
						playerspotted = true
						$VisionRaycast.debug_shape_custom_color = Color(174, 0, 0)
						$SpotLight3D.set_color("c81805")
						print("Target spotted")
					else:
						playerspotted = false
						$VisionRaycast.debug_shape_custom_color = Color(0, 255, 0)
						$SpotLight3D.set_color("00ec2d")
						print("Target lost")
						get_tree().create_timer(1.0).timeout
						ANIMATIONPLAYER.play("global/enemyrotate")

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		enemy_in_range = true
		$attack_delay.start()


func _on_player_player_death():
	player_dead = true
	
func enemy_survey():
	pass


func _on_attack_area_body_exited(body):
	if body.is_in_group("player"):
		enemy_in_range = false
		$attack_delay.stop()


func _on_attack_delay_timeout():
	if enemy_in_range == true:
		emit_signal("enemy_hit")
		$attack_delay.start()




func _on_enemy_death():
	velocity = Vector3.ZERO
	get_node("animationsfolder/AnimationPlayer").play("death")
	


func _on_animationsfolder_enemy_death_anim():
	queue_free()
