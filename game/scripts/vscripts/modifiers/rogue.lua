rogue = class ({})

function rogue:IsHidden()
	return false
end

function rogue:IsPurgable()
	return false
end

function rogue:IsPermanent()
	return true
end

function rogue:RemoveOnDeath()
	return false
end

function rogue:GetTexture()
	return "lone_druid_spirit_bear_defender"
end

function rogue:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
    return funcs
end

function rogue:GetModifierMoveSpeedBonus_Constant()
	return 20
end

function rogue:GetModifierEvasion_Constant()
	return 9.9
end

function rogue:GetModifierTotalDamageOutgoing_Percentage()
	return 5
end