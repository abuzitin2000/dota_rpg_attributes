stats = class ({})

LinkLuaModifier("strength", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("dexterity", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("constitution", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("constitution10", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("constitution100", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("constitution_status", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("intelligence", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisdom", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisdom10", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisdom100", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wisdom_cdr", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("charisma", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("luck", "modifiers/stats", LUA_MODIFIER_MOTION_NONE)

function stats:IsHidden()
	return true
end

function stats:IsPurgable()
	return false
end

function stats:IsPermanent()
	return true
end

function stats:RemoveOnDeath()
	return false
end

function stats:GetTexture()
	return "lone_druid_spirit_bear_defender"
end

function stats:OnCreated()
	if not IsServer() then
		return
	end

	self.points = 43
	self.strength = 0
	self.dexterity = 0
	self.constitution = 0
	self.intelligence = 0
	self.wisdom = 0
	self.charisma = 0
	self.luck = 0

	parent = self:GetParent()

	self.strengthBuff = parent:AddNewModifier(parent, nil, "strength", {})
	self.dexterityBuff = parent:AddNewModifier(parent, nil, "dexterity", {})
	self.constitutionBuff = parent:AddNewModifier(parent, nil, "constitution_status", {})
	self.intelligenceBuff = parent:AddNewModifier(parent, nil, "intelligence", {})
	self.wisdomBuff = parent:AddNewModifier(parent, nil, "wisdom_cdr", {})
	self.charismaBuff = parent:AddNewModifier(parent, nil, "charisma", {})
	self.luckBuff = parent:AddNewModifier(parent, nil, "luck", {})
end

function stats:ChangeStats()
	self.strengthBuff:SetStackCount(self.strength)
	self.dexterityBuff:SetStackCount(self.dexterity)
	self.constitutionBuff:SetStackCount(self.constitution)
	self.intelligenceBuff:SetStackCount(self.intelligence)
	self.wisdomBuff:SetStackCount(self.wisdom)
	self.charismaBuff:SetStackCount(self.charisma)
	self.luckBuff:SetStackCount(self.luck)
end

strength = class ({})

function strength:IsHidden()
	return true
end

function strength:IsPurgable()
	return false
end

function strength:IsPermanent()
	return true
end

function strength:RemoveOnDeath()
	return false
end

function strength:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
    }
    return funcs
end

function strength:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * 4.85
end

dexterity = class ({})

function dexterity:IsHidden()
	return true
end

function dexterity:IsPurgable()
	return false
end

function dexterity:IsPermanent()
	return true
end

function dexterity:RemoveOnDeath()
	return false
end

function dexterity:DeclareFunctions()
    local funcs = {
    	MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
    return funcs
end

function dexterity:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * 3.675
end

function dexterity:GetModifierPhysicalArmorBonus()
	return self:GetStackCount() * 0.375
end

function dexterity:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount() * 1.45
end

constitution = class ({})

function constitution:IsHidden()
	return true
end

function constitution:IsPurgable()
	return false
end

function constitution:IsPermanent()
	return true
end

function constitution:RemoveOnDeath()
	return false
end

function constitution:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function constitution:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function constitution:GetModifierHealthBonus()
	return 45
end

function constitution:GetModifierConstantHealthRegen()
	return 0.295
end

constitution10 = class ({})

function constitution10:IsHidden()
	return true
end

function constitution10:IsPurgable()
	return false
end

function constitution10:IsPermanent()
	return true
end

function constitution10:RemoveOnDeath()
	return false
end

function constitution10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function constitution10:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function constitution10:GetModifierHealthBonus()
	return 45 * 10
end

function constitution10:GetModifierConstantHealthRegen()
	return 0.295 * 10
end

constitution100 = class ({})

function constitution100:IsHidden()
	return true
end

function constitution100:IsPurgable()
	return false
end

function constitution100:IsPermanent()
	return true
end

function constitution100:RemoveOnDeath()
	return false
end

function constitution100:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function constitution100:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
    return funcs
end

function constitution100:GetModifierHealthBonus()
	return 45 * 100
end

function constitution100:GetModifierConstantHealthRegen()
	return 0.295 * 100
end

constitution_status = class ({})

function constitution_status:IsHidden()
	return true
end

function constitution_status:IsPurgable()
	return false
end

function constitution_status:IsPermanent()
	return true
end

function constitution_status:RemoveOnDeath()
	return false
end

function constitution_status:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_MODEL_SCALE
    }
    return funcs
end

function constitution_status:GetModifierStatusResistanceStacking()
	return (1 - math.pow(0.99, self:GetStackCount())) * 95
end

function constitution_status:GetModifierModelScale()
	return self:GetStackCount() / 6
end

intelligence = class ({})

function intelligence:IsHidden()
	return true
end

function intelligence:IsPurgable()
	return false
end

function intelligence:IsPermanent()
	return true
end

function intelligence:RemoveOnDeath()
	return false
end

function intelligence:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
    return funcs
end

function intelligence:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount() * 1.85
end

function intelligence:GetModifierMagicalResistanceBonus()
	return (1 - math.pow(0.992, self:GetStackCount())) * 100
end

wisdom = class ({})

function wisdom:IsHidden()
	return true
end

function wisdom:IsPurgable()
	return false
end

function wisdom:IsPermanent()
	return true
end

function wisdom:RemoveOnDeath()
	return false
end

function wisdom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function wisdom:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function wisdom:GetModifierManaBonus()
	return 40
end

function wisdom:GetModifierConstantManaRegen()
	return 0.235
end

wisdom10 = class ({})

function wisdom10:IsHidden()
	return true
end

function wisdom10:IsPurgable()
	return false
end

function wisdom10:IsPermanent()
	return true
end

function wisdom10:RemoveOnDeath()
	return false
end

function wisdom10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function wisdom10:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function wisdom10:GetModifierManaBonus()
	return 40 * 10
end

function wisdom10:GetModifierConstantManaRegen()
	return 0.235 * 10
end

wisdom100 = class ({})

function wisdom100:IsHidden()
	return true
end

function wisdom100:IsPurgable()
	return false
end

function wisdom100:IsPermanent()
	return true
end

function wisdom100:RemoveOnDeath()
	return false
end

function wisdom100:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function wisdom100:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
    }
    return funcs
end

function wisdom100:GetModifierManaBonus()
	return 40 * 100
end

function wisdom100:GetModifierConstantManaRegen()
	return 0.235 * 100
end

wisdom_cdr = class ({})

function wisdom_cdr:IsHidden()
	return true
end

function wisdom_cdr:IsPurgable()
	return false
end

function wisdom_cdr:IsPermanent()
	return true
end

function wisdom_cdr:RemoveOnDeath()
	return false
end

function wisdom_cdr:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_STACKING
    }
    return funcs
end

function wisdom_cdr:GetModifierPercentageCooldownStacking()
	return (1 - math.pow(0.992, self:GetStackCount())) * 90
end

charisma = class ({})

function charisma:IsHidden()
	return true
end

function charisma:IsPurgable()
	return false
end

function charisma:IsPermanent()
	return true
end

function charisma:RemoveOnDeath()
	return false
end

function charisma:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_GOLD_RATE_BOOST,
        MODIFIER_PROPERTY_RESPAWNTIME_PERCENTAGE
    }
    return funcs
end

function charisma:GetModifierPercentageGoldRateBoost()
	return self:GetStackCount() * 1.35
end

function charisma:GetModifierPercentageRespawnTime()
	return 1 - math.pow(0.99, self:GetStackCount())
end

luck = class ({})

function luck:IsHidden()
	return true
end

function luck:IsPurgable()
	return false
end

function luck:IsPermanent()
	return true
end

function luck:RemoveOnDeath()
	return false
end

function luck:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
    return funcs
end

function luck:GetModifierOverrideAbilitySpecial( params )
	local ability = params.ability
	local abilityName = ability:GetAbilityName()
	local specialName = params.ability_special_value

	-- Axe
	if abilityName == "axe_counter_helix" then
		if specialName == "trigger_chance" then
			return 1
		end
	end

	-- Brewmaster
	if abilityName == "brewmaster_drunken_brawler" then
		if specialName == "dodge_chance" or specialName == "crit_chance" then
			return 1
		end
	end

	-- Broodmother
	if abilityName == "broodmother_silken_bola" then
		if specialName == "miss_chance" then
			return 1
		end
	end

	-- Chaos Knight
	if abilityName == "chaos_knight_chaos_bolt" then
		if specialName == "stun_min" or specialName == "damage_min" then
			return 1
		end
	end

	if abilityName == "chaos_knight_chaos_strike" then
		if specialName == "chance" then
			return 1
		end
	end

	-- Dawn
	if abilityName == "dawnbreaker_solar_guardian" then
		if specialName == "miss_rate" then
			return 1
		end
	end

	-- Drow
	if abilityName == "drow_ranger_marksmanship" then
		if specialName == "chance" then
			return 1
		end
	end

	-- Druid
	if abilityName == "lone_druid_spirit_bear_entangle" then
		if specialName == "entangle_chance" then
			return 1
		end
	end

	if abilityName == "lone_druid_spirit_bear_entangle" then
		if specialName == "hero_entangle_chance" then
			return 1
		end
	end

	-- Faceless
	if abilityName == "faceless_void_time_lock" then
		if specialName == "chance_pct" then
			return 1
		end
	end

	if abilityName == "special_bonus_unique_faceless_void_4" then
		if specialName == "dodge_chance_pct" then
			return 1
		end
	end

	-- Hoodwink
	if abilityName == "hoodwink_scurry" then
		if specialName == "evasion" then
			return 1
		end
	end

	-- Juggernaut
	if abilityName == "juggernaut_blade_dance" then
		if specialName == "blade_dance_crit_chance" then
			return 1
		end
	end

	-- KOTL
	if abilityName == "keeper_of_the_light_blinding_light" then
		if specialName == "miss_rate" then
			return 1
		end
	end

	-- Legion
	if abilityName == "legion_commander_moment_of_courage" then
		if specialName == "trigger_chance" then
			return 1
		end
	end

	-- Lycan
	if abilityName == "lycan_shapeshift" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	-- Mars
	if abilityName == "mars_bulwark" then
		if specialName == "redirect_chance" then
			return 1
		end
	end

	-- Naga
	if abilityName == "naga_siren_rip_tide" then
		if specialName == "chance" then
			return 1
		end
	end

	-- Outworld
	if abilityName == "obsidian_destroyer_equilibrium" then
		if specialName == "proc_chance" then
			return 1
		end
	end

	-- Ogre
	if abilityName == "ogre_magi_multicast" then
		if specialName == "multicast_2_times" or specialName == "multicast_3_times" or specialName == "multicast_4_times" then
			return 1
		end
	end

	if abilityName == "special_bonus_20_bash_2" then
		if specialName == "value2" then
			return 1
		end
	end

	-- Pangolier
	if abilityName == "pangolier_lucky_shot" then
		if specialName == "chance_pct" then
			return 1
		end
	end

	-- Phantom Assassin
	if abilityName == "phantom_assassin_blur" then
		if specialName == "bonus_evasion" then
			return 1
		end
	end

	if abilityName == "phantom_assassin_coup_de_grace" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	-- Phantom Lancer
	if abilityName == "phantom_lancer_juxtapose" then
		if specialName == "proc_chance_pct" or specialName == "illusion_proc_chance_pct" then
			return 1
		end
	end

	if abilityName == "special_bonus_24_crit_2" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	if abilityName == "special_bonus_evasion_16" then
		if specialName == "value" then
			return 1
		end
	end

	-- Riki
	if abilityName == "riki_smoke_screen" then
		if specialName == "miss_rate" then
			return 1
		end
	end

	-- Sand King
	if abilityName == "special_bonus_unique_sand_king_4" then
		if specialName == "value" then
			return 1
		end
	end

	-- Sniper
	if abilityName == "sniper_headshot" then
		if specialName == "proc_chance" then
			return 1
		end
	end

	-- Spirit Breaker
	if abilityName == "spirit_breaker_greater_bash" then
		if specialName == "chance_pct" then
			return 1
		end
	end

	-- Troll
	if abilityName == "troll_warlord_berserkers_rage" then
		if specialName == "ensnare_chance" then
			return 1
		end
	end

	if abilityName == "troll_warlord_whirling_axes_melee" then
		if specialName == "blind_pct" then
			return 1
		end
	end

	if abilityName == "special_bonus_evasion_20" then
		if specialName == "value" then
			return 1
		end
	end

	-- Tusk
	if abilityName == "special_bonus_unique_tusk_4" then
		if specialName == "value" then
			return 1
		end
	end

	-- Templar
	if abilityName == "special_bonus_evasion_15" then
		if specialName == "value" then
			return 1
		end
	end

	-- Abbysal
	if abilityName == "item_basher" then
		if specialName == "bash_chance_melee" then
			return 1
		end
	end

	if abilityName == "item_basher" then
		if specialName == "bash_chance_ranged" then
			return 1
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "block_chance" then
			return 1
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "bash_chance_melee" then
			return 1
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "bash_chance_ranged" then
			return 1
		end
	end

	-- Butterfly
	if abilityName == "item_talisman_of_evasion" then
		if specialName == "bonus_evasion" then
			return 1
		end
	end

	if abilityName == "item_butterfly" then
		if specialName == "bonus_evasion" then
			return 1
		end
	end

	-- Crit
	if abilityName == "item_lesser_crit" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	if abilityName == "item_silver_edge" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	if abilityName == "item_greater_crit" then
		if specialName == "crit_chance" then
			return 1
		end
	end

	-- Vanguard
	if abilityName == "item_vanguard" then
		if specialName == "block_chance" then
			return 1
		end
	end

	if abilityName == "item_crimson_guard" then
		if specialName == "block_chance" then
			return 1
		end
	end

	-- MKB
	if abilityName == "item_javelin" then
		if specialName == "bonus_chance" then
			return 1
		end
	end

	if abilityName == "item_monkey_king_bar" then
		if specialName == "bonus_chance" then
			return 1
		end
	end

	-- Radiance
	if abilityName == "item_radiance" then
		if specialName == "blind_pct" then
			return 1
		end
	end

	-- Maelstrom
	if abilityName == "item_maelstrom" then
		if specialName == "chain_chance" then
			return 1
		end
	end

	if abilityName == "item_gungir" then
		if specialName == "chain_chance" then
			return 1
		end
	end

	if abilityName == "item_mjollnir" then
		if specialName == "static_chance" then
			return 1
		end
	end

	if abilityName == "item_mjollnir" then
		if specialName == "chain_chance" then
			return 1
		end
	end

    return 0
end

function luck:GetModifierOverrideAbilitySpecialValue( params )
	local ability = params.ability
	local abilityName = ability:GetAbilityName()
	local specialName = params.ability_special_value
	local specialLevel = params.ability_special_level

	local chance = ability:GetLevelSpecialValueNoOverride(specialName, specialLevel)

	local newChance = (1 - math.pow(0.98, self:GetStackCount())) * (100 - chance)
	chance = chance + newChance

	if chance > 100 then
		chance = 100
	end

	-- Axe
	if abilityName == "axe_counter_helix" then
		if specialName == "trigger_chance" then
			return chance
		end
	end

	-- Brewmaster
	if abilityName == "brewmaster_drunken_brawler" then
		if specialName == "dodge_chance" or specialName == "crit_chance" then
			return chance
		end
	end

	-- Broodmother
	if abilityName == "broodmother_silken_bola" then
		if specialName == "miss_chance" then
			return chance
		end
	end

	-- Chaos Knight
	if abilityName == "chaos_knight_chaos_bolt" then
		if specialName == "stun_min" or specialName == "damage_min" then
			return chance
		end
	end

	if abilityName == "chaos_knight_chaos_strike" then
		if specialName == "chance" then
			return chance
		end
	end

	-- Dawn
	if abilityName == "dawnbreaker_solar_guardian" then
		if specialName == "miss_rate" then
			return chance
		end
	end

	-- Drow
	if abilityName == "drow_ranger_marksmanship" then
		if specialName == "chance" then
			return chance
		end
	end

	-- Druid
	if abilityName == "lone_druid_spirit_bear_entangle" then
		if specialName == "entangle_chance" then
			return chance
		end
	end

	if abilityName == "lone_druid_spirit_bear_entangle" then
		if specialName == "hero_entangle_chance" then
			return chance
		end
	end

	-- Faceless
	if abilityName == "faceless_void_time_lock" then
		if specialName == "chance_pct" then
			return chance
		end
	end

	if abilityName == "special_bonus_unique_faceless_void_4" then
		if specialName == "dodge_chance_pct" then
			return chance
		end
	end

	-- Hoodwink
	if abilityName == "hoodwink_scurry" then
		if specialName == "evasion" then
			return chance
		end
	end

	-- Juggernaut
	if abilityName == "juggernaut_blade_dance" then
		if specialName == "blade_dance_crit_chance" then
			return chance
		end
	end

	-- KOTL
	if abilityName == "keeper_of_the_light_blinding_light" then
		if specialName == "miss_rate" then
			return chance
		end
	end

	-- Legion
	if abilityName == "legion_commander_moment_of_courage" then
		if specialName == "trigger_chance" then
			return chance
		end
	end

	-- Lycan
	if abilityName == "lycan_shapeshift" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	-- Mars
	if abilityName == "mars_bulwark" then
		if specialName == "redirect_chance" then
			return chance
		end
	end

	-- Naga
	if abilityName == "naga_siren_rip_tide" then
		if specialName == "chance" then
			return chance
		end
	end

	-- Outworld
	if abilityName == "obsidian_destroyer_equilibrium" then
		if specialName == "proc_chance" then
			return chance
		end
	end

	-- Ogre
	if abilityName == "ogre_magi_multicast" then
		if specialName == "multicast_2_times" or specialName == "multicast_3_times" or specialName == "multicast_4_times" then
			return chance
		end
	end

	if abilityName == "special_bonus_20_bash_2" then
		if specialName == "value2" then
			return chance
		end
	end

	-- Pangolier
	if abilityName == "pangolier_lucky_shot" then
		if specialName == "chance_pct" then
			return chance
		end
	end

	-- Phantom Assassin
	if abilityName == "phantom_assassin_blur" then
		if specialName == "bonus_evasion" then
			return chance
		end
	end

	if abilityName == "phantom_assassin_coup_de_grace" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	-- Phantom Lancer
	if abilityName == "phantom_lancer_juxtapose" then
		if specialName == "proc_chance_pct" or specialName == "illusion_proc_chance_pct" then
			return chance
		end
	end

	if abilityName == "special_bonus_24_crit_2" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	if abilityName == "special_bonus_evasion_16" then
		if specialName == "value" then
			return chance
		end
	end

	-- Riki
	if abilityName == "riki_smoke_screen" then
		if specialName == "miss_rate" then
			return chance
		end
	end

	-- Sand King
	if abilityName == "special_bonus_unique_sand_king_4" then
		if specialName == "value" then
			return chance
		end
	end

	-- Sniper
	if abilityName == "sniper_headshot" then
		if specialName == "proc_chance" then
			return chance
		end
	end

	-- Spirit Breaker
	if abilityName == "spirit_breaker_greater_bash" then
		if specialName == "chance_pct" then
			return chance
		end
	end
	
	-- Troll
	if abilityName == "troll_warlord_berserkers_rage" then
		if specialName == "ensnare_chance" then
			return chance
		end
	end

	if abilityName == "troll_warlord_whirling_axes_melee" then
		if specialName == "blind_pct" then
			return chance
		end
	end

	if abilityName == "special_bonus_evasion_20" then
		if specialName == "value" then
			return chance
		end
	end

	-- Tusk
	if abilityName == "special_bonus_unique_tusk_4" then
		if specialName == "value" then
			return chance
		end
	end

	-- Templar
	if abilityName == "special_bonus_evasion_15" then
		if specialName == "value" then
			return chance
		end
	end

	-- Abbysal
	if abilityName == "item_basher" then
		if specialName == "bash_chance_melee" then
			return chance
		end
	end

	if abilityName == "item_basher" then
		if specialName == "bash_chance_ranged" then
			return chance
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "block_chance" then
			return chance
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "bash_chance_melee" then
			return chance
		end
	end

	if abilityName == "item_abyssal_blade" then
		if specialName == "bash_chance_ranged" then
			return chance
		end
	end

	-- Butterfly
	if abilityName == "item_talisman_of_evasion" then
		if specialName == "bonus_evasion" then
			return chance
		end
	end

	if abilityName == "item_butterfly" then
		if specialName == "bonus_evasion" then
			return chance
		end
	end

	-- Crit
	if abilityName == "item_lesser_crit" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	if abilityName == "item_silver_edge" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	if abilityName == "item_greater_crit" then
		if specialName == "crit_chance" then
			return chance
		end
	end

	-- Vanguard
	if abilityName == "item_vanguard" then
		if specialName == "block_chance" then
			return chance
		end
	end

	if abilityName == "item_crimson_guard" then
		if specialName == "block_chance" then
			return chance
		end
	end

	-- MKB
	if abilityName == "item_javelin" then
		if specialName == "bonus_chance" then
			return chance
		end
	end

	if abilityName == "item_monkey_king_bar" then
		if specialName == "bonus_chance" then
			return chance
		end
	end

	-- Radiance
	if abilityName == "item_radiance" then
		if specialName == "blind_pct" then
			return chance
		end
	end

	-- Maelstrom
	if abilityName == "item_maelstrom" then
		if specialName == "chain_chance" then
			return chance
		end
	end

	if abilityName == "item_gungir" then
		if specialName == "chain_chance" then
			return chance
		end
	end

	if abilityName == "item_mjollnir" then
		if specialName == "static_chance" then
			return chance
		end
	end

	if abilityName == "item_mjollnir" then
		if specialName == "chain_chance" then
			return chance
		end
	end

    return nil
end