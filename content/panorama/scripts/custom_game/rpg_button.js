let button = $.GetContextPanel().FindChildTraverse("RPGButtonPanel");
let stats = $.GetContextPanel().FindChildTraverse("RPGStatsPanel");
let remainingText = $.GetContextPanel().FindChildTraverse("RPGStatsRemaining");
let strengthText = $.GetContextPanel().FindChildTraverse("StrengthNumber");
let dexterityText = $.GetContextPanel().FindChildTraverse("DexterityNumber");
let constitutionText = $.GetContextPanel().FindChildTraverse("ConstitutionNumber");
let intelligenceText = $.GetContextPanel().FindChildTraverse("IntelligenceNumber");
let wisdomText = $.GetContextPanel().FindChildTraverse("WisdomNumber");
let charismaText = $.GetContextPanel().FindChildTraverse("CharismaNumber");
let luckText = $.GetContextPanel().FindChildTraverse("LuckNumber");
let portrait = FindDotaHudElement("stats_container");

button.SetParent(portrait);

let points = 0;
let strength = 0;
let dexterity = 0;
let constitution = 0;
let intelligence = 0;
let wisdom = 0;
let charisma = 0;
let luck = 0;

function toggleRPG() {
	if (stats.style.opacity == 1) {
		stats.style.opacity = 0;
	} else {
		stats.style.opacity = 1;
		getPoints()
	}
}

function addStrength() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "strength", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addDexterity() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "dexterity", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addConstitution() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "constitution", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addIntelligence() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "intelligence", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addWisdom() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "wisdom", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addCharisma() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "charisma", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function addLuck() {
	GameEvents.SendCustomGameEventToServer("addStat", { "PlayerID" : Players.GetLocalPlayer(), "stat": "luck", "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function getPoints() {
	GameEvents.SendCustomGameEventToServer("getPoints", { "PlayerID" : Players.GetLocalPlayer(), "Unit" : Players.GetLocalPlayerPortraitUnit() });
}

function setPoints( event ) {
	if (event.lvlup && Players.GetLocalPlayerPortraitUnit() != Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())) {
		return;
	}

	points = event.points;
	strength = event.strength;
	dexterity = event.dexterity;
	constitution = event.constitution;
	intelligence = event.intelligence;
	wisdom = event.wisdom;
	charisma = event.charisma;
	luck = event.luck;

	putPoints();
	refreshColor();
}

function putPoints() {
	remainingText.text = "Points Remaining: " + points;
	strengthText.text = strength
	dexterityText.text = dexterity
	constitutionText.text = constitution
	intelligenceText.text = intelligence
	wisdomText.text = wisdom
	charismaText.text = charisma
	luckText.text = luck

	if (points > 0) {
		remainingText.style.color = "white";
	} else {
		remainingText.style.color = "red";
	}
}

function refreshColor() {
	if (points > 0) {
		button.style.opacityBrush = "rgba(158, 139, 78, 1)";
		button.style.opacity = "8";
		button.style.boxShadow = "0px 0px 50px rgba(179, 159, 100, 0.15)";
	} else {
		button.style.opacityBrush = "rgba(255, 255, 255, 1)";
		button.style.opacity = "1";
		button.style.boxShadow = "0px 0px 0px rgba(0, 0, 0, 0)";
	}
}

GameEvents.Subscribe("setPoints", setPoints);

function changePortrait() {
	getPoints();
}

GameEvents.Subscribe("dota_player_update_query_unit", changePortrait);
GameEvents.Subscribe("dota_player_update_selected_unit", changePortrait);

function statsUp() {
	addStrength();
	addDexterity();
	addConstitution();
	addIntelligence();
	addWisdom();
	addCharisma();
	addLuck();
}

GameEvents.Subscribe("statsUp", statsUp);

function OnCustomGameExecuteCloseTab() {
	toggleRPG()
}

(function() {
	Game.AddCommand( "+CustomGameExecuteCloseTab", OnCustomGameExecuteCloseTab, "", 0 );
})();