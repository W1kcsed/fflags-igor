-- FFlags Optimizer для Roblox (Executor Compatible)
-- Применяет все оптимизационные флаги через инжектор

local function applyFFlags()
    -- Проверка окружения
    if not game or not game:GetService("Players") then
        warn("⚠️ Ошибка: Скрипт должен быть запущен в игре Roblox!")
        return false
    end
    
    print("=" .. string.rep("=", 50))
    print("🚀 FFlags Optimizer для Roblox")
    print("=" .. string.rep("=", 50))
    print("")
    
    -- Конфигурация FFLags
    local FFlagsConfig = {
        -- Телеметрия (отключение)
        ["DFFlagClientLightingTechnologyChangedTelemetryTrackTimeSpent"] = "False",
        ["DFFlagAvatarChatTelemetryAddTrackingTimeToSessionTracking2"] = "False",
        ["DFFlagPolicyServiceReportDetailIsNotSubjectToChinaPolicies"] = "False",
        ["DFFlagFFlagRolloutDuplicateRobloxTelemetryCountersEnabled"] = "False",
        ["DFFlagAvatarChatTelemetryAddTrackingTimeToSessionTracking"] = "False",
        ["DFFlagFixRobloxTelemetryEphemeralCountersAndStatsCategory"] = "False",
        ["DFFlagPerformanceControlIXPAllowCustomTelemetryThrottles"] = "False",
        ["DFFlagUpdateBoundExtentsForHugeMixedReplicationComponents"] = "True",
        ["DFFlagMeshNetLockSocketsOnShutdownWhileWritingToSocket"] = "False",
        ["DFFlagVoiceChatPossibleDuplicateSubscriptionsTelemetry"] = "False",
        ["DFFlagSimEnvironmentAddMinimumDensityRolloutTelemetry"] = "False",
        ["DFFlagAvatarChatServiceTelemetryIncludeServerFeatures"] = "False",
        ["DFFlagFaceAnimatorServiceTelemetryIncludeTrackerMode"] = "False",
        ["DFFlagPolicyServiceReportIsNotSubjectToChinaPolicies"] = "False",
        ["DFFlagRakNetUnblockSelectOnShutdownByWritingToSocket"] = "True",
        ["DFFlagFFlagRolloutDuplicateTelemetryCountersEnabled"] = "False",
        ["DFFlagAllowRegistrationOfAnimationClipInCoreScripts"] = "true",
        ["DFFlagTeleportClientAssetPreloadingDoingExperiment2"] = "True",
        ["DFFlagNetworkHumanoidStatePropertyReplicationWarmup"] = "True",
        
        -- Integer FFlags (оптимизация производительности)
        ["DFIntTaskSchedulerTargetFps"] = "9999",
        ["DFIntS2PhysicsSenderRate"] = "250",
        ["DFIntNetworkReceiveRate"] = "300",
        ["DFIntNetworkSendRate"] = "300",
        ["DFIntServerTickRate"] = "90",
        ["DFIntDataSenderRate"] = "4",
        ["DFIntMaxPacketSize"] = "1350",
        ["DFIntConnectionMTUSize"] = "1200",
        
        -- Feature FFlags (оптимизация)
        ["FFlagDebugDisplayFPS"] = "True",
        ["FFlagOptimizeNetwork"] = "True",
        ["FFlagEnableQuickGameLaunch"] = "True",
        ["FFlagDisablePostFx"] = "True",
        ["FFlagNewLightAttenuation"] = "True",
        ["FFlagFastGPULightCulling3"] = "True",
        ["FFlagDebugForceFutureIsBrightPhase2"] = "True",
        ["FFlagDebugForceFutureIsBrightPhase3"] = "True",
        ["FFlagBatchAssetApi"] = "True",
        ["FFlagEnableRbxPostAPI"] = "True",
        
        -- String FFlags
        ["DFStringCrashUploadToBacktraceWindowsPlayerToken"] = "null",
        ["DFStringCrashUploadToBacktraceMacPlayerToken"] = "null",
        ["DFStringAnalyticsEventStreamUrlEndpoint"] = "null",
        ["DFStringCrashUploadToBacktraceBaseUrl"] = "null",
        ["DFStringRobloxAnalyticsSubDomain"] = "opt-out",
        ["DFStringRobloxAnalyticsURL"] = "null",
        ["DFStringTelemetryV2Url"] = "null",
    }
    
    -- Применение флагов через settings()
    local successCount = 0
    local failCount = 0
    
    for flagName, flagValue in pairs(FFlagsConfig) do
        local success = pcall(function()
            -- Попытка установить флаг через settings()
            if type(flagValue) == "string" then
                if flagValue == "True" or flagValue == "true" then
                    settings():SetFFlag(flagName, true)
                elseif flagValue == "False" or flagValue == "false" then
                    settings():SetFFlag(flagName, false)
                else
                    settings():SetFFlag(flagName, flagValue)
                end
            elseif type(flagValue) == "number" then
                settings():SetFFlag(flagName, flagValue)
            end
        end)
        
        if success then
            successCount = successCount + 1
        else
            failCount = failCount + 1
        end
    end
    
    print("✅ Успешно применено флагов: " .. successCount)
    print("❌ Не удалось применить флагов: " .. failCount)
    print("")
    
    -- Дополнительная оптимизация
    print("🔧 Применение дополнительных оптимизаций...")
    
    -- Оптимизация рендеринга
    local success, err = pcall(function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        Lighting.Brightness = 2
        
        -- Отключение эффектов
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") then
                effect.Enabled = false
            end
        end
        
        print("   ✓ Оптимизация освещения")
    end)
    
    -- Оптимизация текстур
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        print("   ✓ Оптимизация качества графики")
    end)
    
    -- Оптимизация физики
    pcall(function()
        local PhysicsSettings = settings().Physics
        PhysicsSettings.AllowSleep = true
        PhysicsSettings.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.DefaultAuto
        print("   ✓ Оптимизация физики")
    end)
    
    -- Оптимизация звука
    pcall(function()
        local SoundService = game:GetService("SoundService")
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 3.33
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 1
        print("   ✓ Оптимизация звука")
    end)
    
    print("")
    print("⚠️  ВАЖНАЯ ИНФОРМАЦИЯ:")
    print("   • Флаги применены в текущей сессии")
    print("   • После перезапуска игры потребуется повторное применение")
    print("   • Некоторые флаги могут не применяться из-за ограничений Roblox")
    print("   • Используйте на свой риск!")
    print("")
    print("=" .. string.rep("=", 50))
    
    return true
end

-- Автоматический запуск
local success, error = pcall(applyFFlags)

if not success then
    warn("❌ Ошибка при применении FFlags: " .. tostring(error))
else
    print("✅ FFlags Optimizer успешно загружен!")
end

-- Удаление всех текстур и эффектов
local function removeAllTexturesAndEffects()
    local textureCount = 0
    local effectCount = 0
    local particleCount = 0
    
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Удаляем текстуры
        if obj:IsA("Texture") or 
           obj:IsA("Decal") or 
           obj:IsA("SurfaceAppearance") then
            obj:Destroy()
            textureCount = textureCount + 1
        end
        
        -- Удаляем эффекты частиц
        if obj:IsA("ParticleEmitter") or 
           obj:IsA("Smoke") or 
           obj:IsA("Fire") or 
           obj:IsA("Sparkles") then
            obj:Destroy()
            particleCount = particleCount + 1
        end
        
        -- Удаляем световые эффекты
        if obj:IsA("PointLight") or 
           obj:IsA("SpotLight") or 
           obj:IsA("SurfaceLight") then
            obj:Destroy()
            effectCount = effectCount + 1
        end
        
        -- Удаляем другие эффекты
        if obj:IsA("Beam") or 
           obj:IsA("Trail") or 
           obj:IsA("BloomEffect") or 
           obj:IsA("BlurEffect") or 
           obj:IsA("ColorCorrectionEffect") or 
           obj:IsA("SunRaysEffect") or 
           obj:IsA("DepthOfFieldEffect") then
            obj:Destroy()
            effectCount = effectCount + 1
        end
    end
    
    print("=== Результаты очистки ===")
    print("Удалено текстур: " .. textureCount)
    print("Удалено частиц: " .. particleCount)
    print("Удалено эффектов: " .. effectCount)
    print("Всего удалено: " .. (textureCount + particleCount + effectCount))
end

removeAllTexturesAndEffects()
