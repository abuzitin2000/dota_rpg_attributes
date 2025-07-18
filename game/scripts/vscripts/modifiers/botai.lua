botai = class ({})

function botai:IsHidden()
	return true
end

function botai:IsPurgable()
	return false
end

function botai:IsPermanent()
	return true
end

function botai:RemoveOnDeath()
	return false
end

function botai:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()

	local class = RandomInt(0, 3)

	if class == 0 then
		parent:AddNewModifier(parent, nil, "fighter", {})
		self.class = "fighter"
	elseif class == 1 then
		parent:AddNewModifier(parent, nil, "rogue", {})
		self.class = "rogue"
	elseif class == 2 then
		parent:AddNewModifier(parent, nil, "mage", {})
		self.class = "mage"
	else
		parent:AddNewModifier(parent, nil, "cleric", {})
		self.class = "cleric"
	end

	self.stats = parent:AddNewModifier(parent, nil, "stats", {})
	self.stats.points = self.stats.points + 3

	for i = 1, 4 do
		AddStat( { hero = parent:entindex(), stat = "strength" } )
		AddStat( { hero = parent:entindex(), stat = "dexterity" } )
		AddStat( { hero = parent:entindex(), stat = "constitution" } )
		AddStat( { hero = parent:entindex(), stat = "intelligence" } )
		AddStat( { hero = parent:entindex(), stat = "wisdom" } )
		AddStat( { hero = parent:entindex(), stat = "charisma" } )
		AddStat( { hero = parent:entindex(), stat = "luck" } )
	end

	for i = 1, 18 do
		ChooseStat( parent:entindex() )
	end

	self.lvl = 1

	self:StartIntervalThink(1)
end

function botai:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local lvl = parent:GetLevel()

	if lvl > self.lvl then
		AddStat( { hero = parent:entindex(), stat = "strength" } )
		AddStat( { hero = parent:entindex(), stat = "dexterity" } )
		AddStat( { hero = parent:entindex(), stat = "constitution" } )
		AddStat( { hero = parent:entindex(), stat = "intelligence" } )
		AddStat( { hero = parent:entindex(), stat = "wisdom" } )
		AddStat( { hero = parent:entindex(), stat = "charisma" } )
		AddStat( { hero = parent:entindex(), stat = "luck" } )

		ChooseStat( parent:entindex() )
		ChooseStat( parent:entindex() )
		ChooseStat( parent:entindex() )
		ChooseStat( parent:entindex() )
		ChooseStat( parent:entindex() )

		self.lvl = self.lvl + 1
	end
end

function ChooseStat( hero )
	local parent = EntIndexToHScript(hero)
	local mod = parent:FindModifierByName("botai")

	if (not mod.stats) or mod.stats.points <= 0 then
		return
	end

	local stat = "strength"

	-- Actual AI
	local class = mod.class
	local rng = RandomInt(0, 100)
	
	if rng < 25 then
		if class == "fighter" then
			stat = "strength"
		elseif class == "rogue" then
			stat = "dexterity"
		elseif class == "mage" then
			stat = "intelligence"
		else
			stat = "wisdom"
		end
	elseif rng < 50 then
		if class == "fighter" then
			stat = "constitution"
		elseif class == "rogue" then
			stat = "luck"
		elseif class == "mage" then
			stat = "wisdom"
		else
			stat = "charisma"
		end
	elseif rng < 70 then
		if class == "fighter" then
			stat = "dexterity"
		elseif class == "rogue" then
			stat = "strength"
		elseif class == "mage" then
			stat = "charisma"
		else
			stat = "intelligence"
		end
	elseif rng < 80 then
		if class == "fighter" then
			stat = "intelligence"
		elseif class == "rogue" then
			stat = "constitution"
		elseif class == "mage" then
			stat = "strength"
		else
			stat = "strength"
		end
	elseif rng < 85 then
		if class == "fighter" then
			stat = "wisdom"
		elseif class == "rogue" then
			stat = "intelligence"
		elseif class == "mage" then
			stat = "dexterity"
		else
			stat = "dexterity"
		end
	elseif rng < 90 then
		if class == "fighter" then
			stat = "charisma"
		elseif class == "rogue" then
			stat = "wisdom"
		elseif class == "mage" then
			stat = "constitution"
		else
			stat = "constitution"
		end
	else
		if class == "fighter" then
			stat = "luck"
		elseif class == "rogue" then
			stat = "charisma"
		elseif class == "mage" then
			stat = "luck"
		else
			stat = "luck"
		end
	end

	AddStat( { hero = hero, stat = stat } )
end

function AddStat( keys )
	local parent = EntIndexToHScript(keys.hero)
	local mod = parent:FindModifierByName("botai")

	mod.stats.points = mod.stats.points - 1

	if keys.stat == "strength" then
		mod.stats.strength = mod.stats.strength + 1
	elseif keys.stat == "dexterity" then
		mod.stats.dexterity = mod.stats.dexterity + 1
	elseif keys.stat == "constitution" then
		mod.stats.constitution = mod.stats.constitution + 1
		parent:AddNewModifier(parent, nil, "constitution", {})

		local modList10 = parent:FindAllModifiersByName("constitution")
		if table.getn(modList10) == 10 then
			parent:RemoveAllModifiersOfName("constitution")
			parent:AddNewModifier(parent, nil, "constitution10", {})
		end

		local modList100 = parent:FindAllModifiersByName("constitution10")
		if table.getn(modList100) == 10 then
			parent:RemoveAllModifiersOfName("constitution10")
			parent:AddNewModifier(parent, nil, "constitution100", {})
		end
	elseif keys.stat == "intelligence" then
		mod.stats.intelligence = mod.stats.intelligence + 1
	elseif keys.stat == "wisdom" then
		mod.stats.wisdom = mod.stats.wisdom + 1
		parent:AddNewModifier(parent, nil, "wisdom", {})

		local modList10 = parent:FindAllModifiersByName("wisdom")
		if table.getn(modList10) == 10 then
			parent:RemoveAllModifiersOfName("wisdom")
			parent:AddNewModifier(parent, nil, "wisdom10", {})
		end

		local modList100 = parent:FindAllModifiersByName("wisdom10")
		if table.getn(modList100) == 10 then
			parent:RemoveAllModifiersOfName("wisdom10")
			parent:AddNewModifier(parent, nil, "wisdom100", {})
		end
	elseif keys.stat == "charisma" then
		mod.stats.charisma = mod.stats.charisma + 1
	elseif keys.stat == "luck" then
		mod.stats.luck = mod.stats.luck + 1
	end

	mod.stats:ChangeStats()
end