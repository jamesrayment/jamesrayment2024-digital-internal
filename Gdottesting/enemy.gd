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

@export var ANIMATIONPLAYER : AnimationPlayer

# identifies global scene for storing variables between scenes
@onready var global = get_node("/root/Global")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var playerspotted = false

func _ready():
	ANIMATIONPLAYER.play("enemyrotate")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Enemy is delted when health is equal or lesser than 0
	if health <= 0:
		global.money += 5
		print("money=", global.money)
		queue_free()
	
	if playerspotted == true and player_dead == false:
		look_at(player.global_position)
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized()*SPEED
		velocity = velocity.move_toward(new_velocity, 2000)
	elif playerspotted == false and player_dead == false:
		velocity = Vector3.ZERO
		get_tree().create_timer(1.0).timeout
	else:
		pass
	
	move_and_slide()
	
	
	#check for if enemy can hit player
	if enemy_in_range == true:
		emit_signal("enemy_hit")
		enemy_in_range = false
	else:
		pass
	
	

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
						playerspotted = true
						$VisionRaycast.debug_shape_custom_color = Color(174, 0, 0)
						print("Target spotted")
						ANIMATIONPLAYER.stop()
					else:
						playerspotted = false
						$VisionRaycast.debug_shape_custom_color = Color(0, 255, 0)
						print("Target lost")
						get_tree().create_timer(1.0).timeout
						ANIMATIONPLAYER.play("enemyrotate")

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		enemy_in_range = true
	else:
		enemy_in_range = false


func _on_player_player_death():
	player_dead = true
	
func enemy_survey():
	pass
