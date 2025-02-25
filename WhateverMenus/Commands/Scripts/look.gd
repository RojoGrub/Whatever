extends MenuCommand

func _on_command(_p : Player = player, _o : Interactive = other, _l : Location = location):
  player.other.look()
