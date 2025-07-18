BUTTINGS = BUTTINGS or {}

ListenToGameEvent("dota_player_killed",function(keys)
	-- for k,v in pairs(keys) do print("dota_player_killed",k,v) end
	local playerID = keys.PlayerID
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill


end, nil)

ListenToGameEvent("entity_killed", function(keys)
	-- for k,v in pairs(keys) do	print("entity_killed",k,v) end
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local killedUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless

	if (killedUnit and killedUnit:IsRealHero()) then
		-- when a hero dies
	end

end, nil)

ListenToGameEvent("npc_spawned", function(keys)
	-- for k,v in pairs(keys) do print("npc_spawned",k,v) end
	local spawnedUnit = keys.entindex and EntIndexToHScript(keys.entindex)

	if spawnedUnit ~= nil then
		-- BOTS
		if spawnedUnit:IsRealHero() then
			if not spawnedUnit:HasModifier("stats") then
				spawnedUnit:AddNewModifier(spawnedUnit, nil, "botai", {})
			end
		end

		-- Experimental summon attributes
		if BUTTINGS.USE_SUMMON == 0 then
			return
		end

		if not spawnedUnit:IsRealHero() then
			local player = spawnedUnit:GetPlayerOwner()

			if not player then
				return
			end

			local heroUnit = player:GetAssignedHero()

			local stats = heroUnit:FindModifierByName("stats")
			local class = heroUnit:FindModifierByName("cleric") or heroUnit:FindModifierByName("fighter") or heroUnit:FindModifierByName("mage") or heroUnit:FindModifierByName("rogue")

			if stats and class then
				spawnedUnit:AddNewModifier(heroUnit, nil, class:GetName(), {})
				local newstats = spawnedUnit:AddNewModifier(heroUnit, nil, "stats", {})

				newstats.points = 0
				newstats.strength = stats.strength
				newstats.dexterity = stats.dexterity
				newstats.constitution = stats.constitution
				newstats.intelligence = stats.intelligence
				newstats.wisdom = stats.wisdom
				newstats.charisma = stats.charisma
				newstats.luck = stats.luck

				for i=1,newstats.constitution do
					spawnedUnit:AddNewModifier(heroUnit, nil, "constitution", {})
				end

				for i=1,newstats.wisdom do
					spawnedUnit:AddNewModifier(heroUnit, nil, "wisdom", {})
				end

				newstats:ChangeStats()
			end
		end
	end

end, nil)

ListenToGameEvent("entity_hurt", function(keys)
	-- for k,v in pairs(keys) do print("entity_hurt",k,v) end
	local damage = keys.damage
	local attackerUnit = keys.entindex_attacker and EntIndexToHScript(keys.entindex_attacker)
	local victimUnit = keys.entindex_killed and EntIndexToHScript(keys.entindex_killed)
	local damagebits = keys.damagebits -- This might always be 0 and therefore useless

end, nil)

ListenToGameEvent("dota_player_gained_level", function(keys)
	-- for k,v in pairs(keys) do print("dota_player_gained_level",k,v) end
	local newLevel = keys.level
	local playerEntindex = keys.player
	local playerUnit = EntIndexToHScript(playerEntindex)
	local heroUnit = playerUnit:GetAssignedHero()
	local player = heroUnit:GetPlayerOwner()

	local stats = heroUnit:FindModifierByName("stats")

	if stats then
		stats.points = stats.points + 12

		CustomGameEventManager:Send_ServerToPlayer(player, "statsUp", {})

		CustomGameEventManager:Send_ServerToPlayer(player, "setPoints", {
			lvlup = true,
			points = stats.points,
			strength = stats.strength,
			dexterity = stats.dexterity,
			constitution = stats.constitution,
			intelligence = stats.intelligence,
			wisdom = stats.wisdom,
			charisma = stats.charisma,
			luck = stats.luck
		})
	end
	
end, nil)

ListenToGameEvent("dota_player_used_ability", function(keys)
	-- for k,v in pairs(keys) do print("dota_player_used_ability",k,v) end
	local casterUnit = keys.caster_entindex and EntIndexToHScript(keys.caster_entindex)
	local abilityname = keys.abilityname
	local playerID = keys.PlayerID
	local player = keys.PlayerID and PlayerResource:GetPlayer(keys.PlayerID)
	-- local ability = casterUnit and casterUnit.FindAbilityByName and casterUnit:FindAbilityByName(abilityname) -- bugs if hero has 2 times the same ability

end, nil)

ListenToGameEvent("last_hit", function(keys)
	-- for k,v in pairs(keys) do print("last_hit",k,v) end
	local killedUnit = keys.EntKilled and EntIndexToHScript(keys.EntKilled)
	local playerID = keys.PlayerID
	local firstBlood = keys.FirstBlood
	local heroKill = keys.HeroKill
	local towerKill = keys.TowerKill

end, nil)

ListenToGameEvent("dota_tower_kill", function(keys)
	-- for k,v in pairs(keys) do print("dota_tower_kill",k,v) end
	local gold = keys.gold
	local towerTeam = keys.teamnumber
	local killer_userid = keys.killer_userid

end, nil)

CustomGameEventManager:RegisterListener("selectClass", function(_,keys)
	local playerID = keys.PlayerID
	local player = playerID and PlayerResource:GetPlayer(playerID)
	local heroUnit = player:GetAssignedHero()

	heroUnit:RemoveAllModifiersOfName("fighter")
	heroUnit:RemoveAllModifiersOfName("rogue")
	heroUnit:RemoveAllModifiersOfName("mage")
	heroUnit:RemoveAllModifiersOfName("cleric")
	heroUnit:RemoveAllModifiersOfName("botai")
	heroUnit:RemoveAllModifiersOfName("constitution")
	heroUnit:RemoveAllModifiersOfName("constitution10")
	heroUnit:RemoveAllModifiersOfName("constitution100")
	heroUnit:RemoveAllModifiersOfName("wisdom")
	heroUnit:RemoveAllModifiersOfName("wisdom10")
	heroUnit:RemoveAllModifiersOfName("wisdom100")
	heroUnit:RemoveAllModifiersOfName("stats")

	heroUnit:AddNewModifier(heroUnit, nil, keys.class, {})
	heroUnit:AddNewModifier(heroUnit, nil, "stats", {})

	local stats = heroUnit:FindModifierByName("stats")

	if stats then
		stats.points = stats.points + 3

		for i=1,4 do
			CustomGameEventManager:Send_ServerToPlayer(player, "statsUp", {})
		end

		CustomGameEventManager:Send_ServerToPlayer(player, "setPoints", {
			lvlup = false,
			points = stats.points,
			strength = stats.strength,
			dexterity = stats.dexterity,
			constitution = stats.constitution,
			intelligence = stats.intelligence,
			wisdom = stats.wisdom,
			charisma = stats.charisma,
			luck = stats.luck
		})
	end

end)

CustomGameEventManager:RegisterListener("addStat", function(_,keys)
	local playerID = keys.PlayerID
	local player = playerID and PlayerResource:GetPlayer(playerID)
	local heroUnit = player:GetAssignedHero()
	local Unit = EntIndexToHScript(keys.Unit)

	if heroUnit ~= Unit then
		return
	end

	local stats = heroUnit:FindModifierByName("stats")

	if stats and stats.points > 0 then
		stats.points = stats.points - 1

		if keys.stat == "strength" then
			stats.strength = stats.strength + 1
		elseif keys.stat == "dexterity" then
			stats.dexterity = stats.dexterity + 1
		elseif keys.stat == "constitution" then
			stats.constitution = stats.constitution + 1
			heroUnit:AddNewModifier(heroUnit, nil, "constitution", {})

			local modList10 = heroUnit:FindAllModifiersByName("constitution")
			if table.getn(modList10) == 10 then
				heroUnit:RemoveAllModifiersOfName("constitution")
				heroUnit:AddNewModifier(heroUnit, nil, "constitution10", {})
			end

			local modList100 = heroUnit:FindAllModifiersByName("constitution10")
			if table.getn(modList100) == 10 then
				heroUnit:RemoveAllModifiersOfName("constitution10")
				heroUnit:AddNewModifier(heroUnit, nil, "constitution100", {})
			end
		elseif keys.stat == "intelligence" then
			stats.intelligence = stats.intelligence + 1
		elseif keys.stat == "wisdom" then
			stats.wisdom = stats.wisdom + 1
			heroUnit:AddNewModifier(heroUnit, nil, "wisdom", {})

			local modList10 = heroUnit:FindAllModifiersByName("wisdom")
			if table.getn(modList10) == 10 then
				heroUnit:RemoveAllModifiersOfName("wisdom")
				heroUnit:AddNewModifier(heroUnit, nil, "wisdom10", {})
			end

			local modList100 = heroUnit:FindAllModifiersByName("wisdom10")
			if table.getn(modList100) == 10 then
				heroUnit:RemoveAllModifiersOfName("wisdom10")
				heroUnit:AddNewModifier(heroUnit, nil, "wisdom100", {})
			end
		elseif keys.stat == "charisma" then
			stats.charisma = stats.charisma + 1
		elseif keys.stat == "luck" then
			stats.luck = stats.luck + 1
		end

		stats:ChangeStats()

		CustomGameEventManager:Send_ServerToPlayer(player, "setPoints", {
			lvlup = false,
			points = stats.points,
			strength = stats.strength,
			dexterity = stats.dexterity,
			constitution = stats.constitution,
			intelligence = stats.intelligence,
			wisdom = stats.wisdom,
			charisma = stats.charisma,
			luck = stats.luck
		})
	end

end)

CustomGameEventManager:RegisterListener("getPoints", function(_,keys)
	local playerID = keys.PlayerID
	local player = playerID and PlayerResource:GetPlayer(playerID)
	local Unit = EntIndexToHScript(keys.Unit)

	local stats = Unit:FindModifierByName("stats")

	if stats then
		CustomGameEventManager:Send_ServerToPlayer(player, "setPoints", {
			lvlup = false,
			points = stats.points,
			strength = stats.strength,
			dexterity = stats.dexterity,
			constitution = stats.constitution,
			intelligence = stats.intelligence,
			wisdom = stats.wisdom,
			charisma = stats.charisma,
			luck = stats.luck
		})
	else
		CustomGameEventManager:Send_ServerToPlayer(player, "setPoints", {
			lvlup = false,
			points = 0,
			strength = 0,
			dexterity = 0,
			constitution = 0,
			intelligence = 0,
			wisdom = 0,
			charisma = 0,
			luck = 0
		})
	end

end)