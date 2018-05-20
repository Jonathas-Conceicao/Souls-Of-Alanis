extends CanvasLayer

signal start_game

func _ready():
  pass
  
func show_message(text):
  $MessageLabel.text = text
  $MessageLabel.show()
  $Timer.start()
    
func show_game_over():
  show_message("Game Over")
  yield($Timer, "timeout")
  $Start.show()
  $MessageLabel.text = "Dodge the\nCreeps!"
  $MessageLabel.show()
  
func update_score(score):
  $ScoreLabel.text = str(score)

func _on_Start_pressed():
    $Start.hide()
    emit_signal("start_game")

func _on_Timer_timeout():
    $MessageLabel.hide()
