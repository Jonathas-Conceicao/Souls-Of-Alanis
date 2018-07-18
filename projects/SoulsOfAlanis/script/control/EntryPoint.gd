extends Area2D

export var blocked = false

func _get_exit():
	return -1

func _on_EntryPoint_body_entered(body):
	if !self.blocked:
		$InteractionSign.visible = true
	return

func _on_EntryPoint_body_exited(body):
	$InteractionSign.visible = false
	return
