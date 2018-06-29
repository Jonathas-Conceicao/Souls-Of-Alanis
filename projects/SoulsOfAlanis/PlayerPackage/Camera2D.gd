extends Camera2D

func _ready():
	self.set_limits()
	return

func set_limits():
	var parent = self.get_parent().get_parent()
	if parent:
		var limits = parent.get_node("CameraLimit")
		if limits:
			var left   = limits.get_node("Left")
			var top    = limits.get_node("Top")
			var right  = limits.get_node("Right")
			var bottom = limits.get_node("Bottom")
			self.limit_left   = left.position.x
			self.limit_top    = top.position.y
			self.limit_right  = right.position.x
			self.limit_bottom = bottom.position.y
	return