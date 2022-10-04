extends Node

const HURT = preload("res://Recursos/Audio/Hurt.wav")
const ATERRIZAJE = preload("res://Recursos/Audio/Aterrizaje.wav")
const SALTO = preload("res://Recursos/Audio/Salto.wav")
const STEP = preload("res://Recursos/Audio/Step.wav")

onready var audioPlayers = $AudioPlayers

func play_audio(sound):
	
	for audioPlayer in audioPlayers.get_children():
		if not audioPlayer.playing:
			audioPlayer.stream = sound
			audioPlayer.play()
			break
