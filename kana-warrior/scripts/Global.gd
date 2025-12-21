extends Node

var selected_kana_set = {}
var selected_background = ""
var selected_rounds := 10
var unlocked_level := 1
var selected_level := 1
var selected_player_data: PlayerData

const HIRAGANA_5 = {
	"あ":"a","い":"i","う":"u","え":"e","お":"o"
}

const HIRAGANA_15 = {
	"あ":"a","い":"i","う":"u","え":"e","お":"o", 
	"か":"ka", "き":"ki", "く":"ku", "け":"ke", "こ":"ko",
	"さ":"sa", "し":"shi", "す":"su", "せ":"se", "そ":"so"
}

const HIRAGANA_25 = {
	"あ":"a","い":"i","う":"u","え":"e","お":"o", 
	"か":"ka", "き":"ki", "く":"ku", "け":"ke", "こ":"ko",
	"さ":"sa", "し":"shi", "す":"su", "せ":"se", "そ":"so",
	"た":"ta", "ち":"chi", "つ":"tsu", "て":"te", "と":"to",
	"な":"na", "に":"ni", "ぬ":"nu", "ね":"ne", "の":"no"
}

const HIRAGANA_35 = {
	"あ":"a","い":"i","う":"u","え":"e","お":"o", 
	"か":"ka", "き":"ki", "く":"ku", "け":"ke", "こ":"ko",
	"さ":"sa", "し":"shi", "す":"su", "せ":"se", "そ":"so",
	"た":"ta", "ち":"chi", "つ":"tsu", "て":"te", "と":"to",
	"な":"na", "に":"ni", "ぬ":"nu", "ね":"ne", "の":"no",
	"は":"ha", "ひ":"hi", "ふ":"fu", "へ":"he", "ほ":"ho",
	"ま":"ma", "み":"mi", "む":"mu", "め":"me", "も":"mo"
}

const HIRAGANA_ALL = {
	"あ":"a","い":"i","う":"u","え":"e","お":"o", 
	"か":"ka", "き":"ki", "く":"ku", "け":"ke", "こ":"ko",
	"さ":"sa", "し":"shi", "す":"su", "せ":"se", "そ":"so",
	"た":"ta", "ち":"chi", "つ":"tsu", "て":"te", "と":"to",
	"な":"na", "に":"ni", "ぬ":"nu", "ね":"ne", "の":"no",
	"は":"ha", "ひ":"hi", "ふ":"fu", "へ":"he", "ほ":"ho",
	"ま":"ma", "み":"mi", "む":"mu", "め":"me", "も":"mo",
	"や":"ya", "ゆ":"yu", "よ":"yo",
	"ら":"ra", "り":"ri", "る":"ru", "れ":"re", "ろ":"ro",
	"わ":"wa", "ん":"n"
}



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
