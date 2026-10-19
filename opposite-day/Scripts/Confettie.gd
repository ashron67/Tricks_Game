extends Area2D

@onready var confetti_1: GPUParticles2D = $confettie
@onready var confetti_2: GPUParticles2D = $confettie2 
@onready var confetti_3: GPUParticles2D = $confettie3
@onready var confetti_4: GPUParticles2D = $confettie4
@onready var sfx_confettie = $"../Sfx_confettie"
var has_triggered: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not has_triggered:
		has_triggered = true
		# 1. First burst 
		confetti_1.restart()
		#Wait 2 seconds
		await get_tree().create_timer(.5).timeout
		confetti_2.restart()
		sfx_confettie.play()
		await get_tree().create_timer(1.0).timeout
		confetti_3.restart()
		sfx_confettie.play()
		await get_tree().create_timer(1.5).timeout
		confetti_4.restart()
		sfx_confettie.play()
