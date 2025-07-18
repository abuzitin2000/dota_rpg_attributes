cleric = class ({})

function cleric:IsHidden()
	return false
end

function cleric:IsPurgable()
	return false
end

function cleric:IsPermanent()
	return true
end

function cleric:RemoveOnDeath()
	return false
end

function cleric:GetTexture()
	return "lone_druid_spirit_bear_defender"
end

function cleric:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE,
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER
    }
    return funcs
end

function cleric:GetModifierHealAmplify_PercentageSource()
	return 20
end

function cleric:GetModifierHPRegenAmplify_Percentage()
	return 20
end

function cleric:GetModifierLifestealRegenAmplify_Percentage()
	return 20
end

function cleric:GetModifierSpellLifestealRegenAmplify_Percentage()
	return 20
end

function cleric:GetModifierStatusResistanceCaster()
	return -20
end