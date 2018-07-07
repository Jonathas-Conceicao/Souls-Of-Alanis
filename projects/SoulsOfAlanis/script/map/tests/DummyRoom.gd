extends Node2D

enum RoomType { loot, ordinary, connection, mission, challange, final, any, avoid }
enum Half { first, second, any }

func _ready():
#	self.set_script(load("res://script/Classes/DummyRoom.gd"))
  pass

func getSceneType():
  printerr("(DB) Inside DummyTree -> getSceneType")
  return connection

func getSceneHalf():
  printerr("(DB) Inside DummyTree -> getSceneHalf")
  return randi() % second

func getMaxRep():
  printerr("(DB) Inside DummyTree -> getMaxRep")
  return randi() % 10

func getNumExit():
  printerr("(DB) Inside DummyTree -> getNumExit")
  return 2# randi() % 4
