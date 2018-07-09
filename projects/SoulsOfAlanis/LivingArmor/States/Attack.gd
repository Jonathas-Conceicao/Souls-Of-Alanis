##
# Base Interface for the State in the FSM
##
extends Node

# Initialize the state
func enter(host):
	if host.data.getHP() <= 0:
		_state_change("Death")
		return
	host.set_animation("Attack")
	host.velocity.x = 0
	host.velocity.y = 0
	return

# Clean up the state
func exit(host):
	return "Walk"

# On physic process
func update(host, delta):
	return

func _on_animation_finished(host, anim_name):
	return "Walk"
