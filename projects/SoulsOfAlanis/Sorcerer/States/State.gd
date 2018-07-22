##
# Base Interface for the State in the FSM
##
extends Node

# Initialize the state
func enter(host):
	host.set_animation("Idle")
	return

# Clean up the state
func exit(host):
	return

func handle_inputIA(host, event):
	return

# On physic process
func update(host, delta):
	return

func _on_animation_finished(host, anim_name):
	return
