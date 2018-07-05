extends 'State.gd'

var direction
var multiplier
var knockedBack

func enter(host):
	host.set_animation("Staggered")
	host.velocity.x = 0
	host.velocity.y = 0
	self.knockedBack = false
	return

func setKnockBack(host, itencity, direction):
	self.multiplier = max(150, 3 * itencity)
	self.direction = direction
	return

func update(host, delta):
	if not knockedBack:
		host.velocity = (multiplier * direction)
		knockedBack = true
	if host.is_on_ceiling():
		host.velocity.y = max(0, host.velocity.y)
		return "Idle"
	if host.is_on_floor() && host.velocity.y >= 0:
		return "Idle"
	if host.is_on_wall() && host.velocity.x != 0:
		return "Idle"
	host.velocity.y += host.GRAVITY
	return

func exit(host):
	host.velocity.x = 0
	host.velocity.y = 0
	var CSprite = host.get_node("Pivot/Body")
	CSprite.set_modulate(Color(1, 1, 1, 1))
	return
