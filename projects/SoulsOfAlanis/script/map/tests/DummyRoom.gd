extends Node2D

export (bool) var debug_mode = true

enum RoomType { loot, ordinary, connection, mission, challange, final, any, avoid }
enum Half { first, second, any }

func _ready():
#	self.set_script(load("res://script/Classes/DummyRoom.gd"))
  pass

func getSceneType():
  debug.printMsg(" Inside DummyTree -> getSceneType", debug.msg_type.dbg, self.debug_mode)
  return connection

func getSceneHalf():
  debug.printMsg(" Inside DummyTree -> getSceneHalf", debug.msg_type.dbg, self.debug_mode)
  return randi() % second

func getMaxRep():
  debug.printMsg(" Inside DummyTree -> getMaxRep", debug.msg_type.dbg, self.debug_mode)
  return randi() % 10

func getNumExit():
  debug.printMsg(" Inside DummyTree -> getNumExit", debug.msg_type.dbg, self.debug_mode)
  return 2# randi() % 4
