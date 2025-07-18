mage = class ({})

function mage:IsHidden()
	return false
end

function mage:IsPurgable()
	return false
end

function mage:IsPermanent()
	return true
end

function mage:RemoveOnDeath()
	return false
end

function mage:GetTexture()
	return "lone_druid_spirit_bear_defender"
end

function mage:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
    }
    return funcs
end

function mage:GetModifierCastRangeBonusStacking()
	return 75
end

function mage:GetModifierPercentageCasttime()
	return 25
end

function mage:GetModifierPercentageManacostStacking()
	return 10
end