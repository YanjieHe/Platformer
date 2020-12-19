extends Area2D


# if the player touches the coin, destories the coin itself and increase the coin counter
func _on_Coin_body_entered(body):
	if body.name == "Player":
		body.n_coins += 1
		update_score(body.n_coins)
		visible = false
		$PickupCoin.play()
		yield($PickupCoin, "finished")
		queue_free()


# update the "score" label
func update_score(n_coins):
	var nodes = get_tree().get_nodes_in_group("Score")
	if len(nodes) == 1:
		var score_label = nodes[0]
		score_label.text = str(n_coins)
