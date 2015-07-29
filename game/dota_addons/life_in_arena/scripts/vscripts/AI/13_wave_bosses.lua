require('LiA_AIcreeps')

function Spawn(entityKeyValues)
	--print("Spawn")
	ABILITY_13_wave_hurl_boulder = thisEntity:FindAbilityByName("13_wave_hurl_boulder")

	thisEntity:SetContextThink( "13_wave_think", Think13Wave , 0.1)
end

function Think13Wave()
	if not thisEntity:IsAlive() then
		return nil 
	end

	if GameRules:IsGamePaused() then
		return 1
	end

	AICreepsAttackOneUnit({unit = thisEntity})
	--print(LiA.AICreepCasts)
		
	if ABILITY_13_wave_hurl_boulder:IsFullyCastable() and LiA.AICreepCasts < LiA.AIMaxCreepCasts then
		local targets = FindUnitsInRadius(thisEntity:GetTeam(), 
						  thisEntity:GetOrigin(), 
						  nil, 
						  600, 
						  DOTA_UNIT_TARGET_TEAM_ENEMY, 
						  DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
						  DOTA_UNIT_TARGET_FLAG_NONE, 
						  FIND_ANY_ORDER, 
						  false)
		if #targets ~= 0 then
			thisEntity:CastAbilityOnTarget(targets[RandomInt(1,#targets)], ABILITY_13_wave_hurl_boulder, -1)
			LiA.AICreepCasts = LiA.AICreepCasts + 1
		end
	end	
	
	return 1
end