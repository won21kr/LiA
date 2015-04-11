function OnCreatedModifier(event)
	local strAdd = event.caster:GetBaseStrength()*event.str_percent*0.01
	event.caster:ModifyStrength(strAdd)
	event.caster:CalculateStatBonus()
	event.ability.strAdd = strAdd
end

function OnDestroyModifier(event)
	event.caster:ModifyStrength(-event.ability.strAdd)
	event.caster:CalculateStatBonus()
end