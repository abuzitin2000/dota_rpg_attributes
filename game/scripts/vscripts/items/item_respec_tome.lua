item_respec_tome = class({})

-- Ability
function item_respec_tome:OnSpellStart()
	local caster = self:GetCaster()
	local stats = caster:FindModifierByName("stats")

	if stats then
		local allocated = stats.strength + stats.dexterity + stats.constitution + stats.intelligence + stats.wisdom + stats.charisma + stats.luck

		if caster:GetGold() < allocated * 30 and GameRules:GetDOTATime(false, false) > 0 then
			HUDError("Not enough gold! You need " .. allocated * 30 .. " gold!", caster:GetPlayerOwnerID())
			return
		else
			if GameRules:GetDOTATime(false, false) > 0 then
				caster:SpendGold(allocated * 30, DOTA_ModifyGold_AbilityCost)
			end

			self:SpendCharge()
			caster:EmitSound("Item.TomeOfKnowledge")
		end

		stats.points = stats.points + allocated

		stats.strength = 0
		stats.dexterity = 0
		stats.constitution = 0
		stats.intelligence = 0
		stats.wisdom = 0
		stats.charisma = 0
		stats.luck = 0

		caster:RemoveAllModifiersOfName("constitution")
		caster:RemoveAllModifiersOfName("constitution10")
		caster:RemoveAllModifiersOfName("constitution100")
		caster:RemoveAllModifiersOfName("wisdom")
		caster:RemoveAllModifiersOfName("wisdom10")
		caster:RemoveAllModifiersOfName("wisdom100")

		stats:ChangeStats()

		CustomGameEventManager:Send_ServerToPlayer(caster:GetPlayerOwner(), "setPoints", {
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
end