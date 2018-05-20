extends Node

export (PackedScene) var Mob
var score = 0

func _ready():
  randomize()
  pass

func game_over():
  $ScoreCounter.stop()
  $Mob.stop()
  $CanvasLayer.show_game_over()
  pass # replace with function body

func new_game():
  score = 0
  $Starter.start()
  $Area2D_Player.start($Position2D.position)

  $CanvasLayer.update_score(score)
  $CanvasLayer.show_message("Get Ready")

  pass

func _on_Starter_timeout():
  $Mob.start()
  $ScoreCounter.start()
  pass # replace with function body


func _on_ScoreCounter_timeout():
  score += 1
  $CanvasLayer.update_score(score)
  pass # replace with function body


func _on_Mob_timeout():
  $Path2D/PathFollow2D.set_offset(randi())
  var mob = Mob.instance()
  add_child(mob)
  var direction = $Path2D/PathFollow2D.rotation + PI/2
  mob.position = $Path2D/PathFollow2D.position
  direction += rand_range(-PI/4, PI/4)
  mob.rotation = direction
  mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
  pass # replace with function body


func _on_CanvasLayer_start_game():
  new_game()
  pass # replace with function body
