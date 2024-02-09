extends Node

@export var mob_scene: PackedScene
var score
func game_over():
	$BGMusic.stop()
	$DEAD.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

 


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	


func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate() # Create a new instance of the Mob scene.=
	var mob_spawn_location = $MobPath/MobSpawnLocation # Choose a random location on Path2D.
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2 # Set the mob's direction perpendicular
														 # to the path direction.
	mob.position = mob_spawn_location.position # Set the mob's position to a random location
	direction += randf_range(-PI / 4, PI / 4) # Add some randomness to the direction.
	mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0) # Choose the velocity for the mob.
	mob.linear_velocity = velocity.rotated(direction)
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
func _ready():
	#new_game()
	pass


func new_game():
	$BGMusic.play()
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready") # with function body.

