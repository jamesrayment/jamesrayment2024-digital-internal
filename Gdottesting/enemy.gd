extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

#enemy health
var health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if health <= 0:
		queue_free()

	move_and_slide()

	


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
						$VisionRaycast.debug_shape_custom_color = Color(174, 0, 0)
						print("Target spotted")
					else:
						$VisionRaycast.debug_shape_custom_color = Color(0, 255, 0)
						print("Target lost")
