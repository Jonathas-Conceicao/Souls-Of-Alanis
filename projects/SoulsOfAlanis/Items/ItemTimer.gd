extends Timer

signal ItemTimeout

var item

func set_item(item):
	self.item = item
	return



func _on_ItemTimer_timeout():
	emit_signal("ItemTimeout", item)
	return
