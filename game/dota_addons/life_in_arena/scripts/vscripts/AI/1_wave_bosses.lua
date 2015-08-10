require('survival/AIcreeps')

function Spawn(entityKeyValues)
	--print("Spawn")
	ABILITY_1_wave_stomp = thisEntity:FindAbilityByName("1_wave_stomp")

	thisEntity:SetContextThink( "1_wave_think", Think1Wave , 0.1)
end

function Think1Wave()
	if not thisEntity:IsAlive() then
		return nil 
	end

	if GameRules:IsGamePaused() then
		return 1
	end

	AICreepsAttackOneUnit({unit = thisEntity})
	--print(Survival.AICreepCasts)
		
	if ABILITY_1_wave_stomp:IsFullyCastable() and Survival.AICreepCasts < Survival.AIMaxCreepCasts then
		local targets = FindUnitsInRadius(thisEntity:GetTeam(), 
						  thisEntity:GetOrigin(), 
						  nil, 
						  250, 
						  DOTA_UNIT_TARGET_TEAM_ENEMY, 
						  DOTA_UNIT_TARGET_ALL - DOTA_UNIT_TARGET_BUILDING, 
						  DOTA_UNIT_TARGET_FLAG_NONE, 
						  FIND_ANY_ORDER, 
						  false)
		--print(#targets)
		if #targets ~= 0 then
			thisEntity:CastAbilityNoTarget(ABILITY_1_wave_stomp, -1)
			Survival.AICreepCasts = Survival.AICreepCasts + 1
		end
	end
	return 1
end