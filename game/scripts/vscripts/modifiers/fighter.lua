fighter = class ({})

function fighter:IsHidden()
	return false
end

function fighter:IsPurgable()
	return false
end

function fighter:IsPermanent()
	return true
end

function fighter:RemoveOnDeath()
	return false
end

function fighter:GetTexture()
	return "lone_druid_spirit_bear_defender"
end

function fighter:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_MAGICAL_CONSTANT_BLOCK,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
    return funcs
end

function fighter:GetModifierPhysical_ConstantBlock( event )
	if event.target ~= self:GetParent() then
		return 0
	end

	if RollPseudoRandom(50, self) then
		return 20
	end

	return 0
end

function fighter:GetModifierMagical_ConstantBlock( event )
	if event.target ~= self:GetParent() then
		return 0
	end
	
	if RollPseudoRandom(50, self) then
		return 10
	end

	return 0
end

function fighter:GetModifierStatusResistanceStacking()
	return 10
end