let classPanel = $.GetContextPanel().FindChildTraverse("RPGClassPanel");

function selectFighter() {
	GameEvents.SendCustomGameEventToServer("selectClass", { "PlayerID" : Players.GetLocalPlayer(), "class": "fighter" });
	classPanel.style.opacity = 0;
}

function selectRogue() {
	GameEvents.SendCustomGameEventToServer("selectClass", { "PlayerID" : Players.GetLocalPlayer(), "class": "rogue" });
	classPanel.style.opacity = 0;
}

function selectMage() {
	GameEvents.SendCustomGameEventToServer("selectClass", { "PlayerID" : Players.GetLocalPlayer(), "class": "mage" });
	classPanel.style.opacity = 0;
}

function selectCleric() {
	GameEvents.SendCustomGameEventToServer("selectClass", { "PlayerID" : Players.GetLocalPlayer(), "class": "cleric" });
	classPanel.style.opacity = 0;
}