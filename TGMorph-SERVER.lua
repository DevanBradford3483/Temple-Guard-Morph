local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

local function applyClothing(character, clothingType, helmetType)
    local clothingFolder = ServerStorage:WaitForChild("Clothing"):WaitForChild("TempleGuard")
    
    local partsToWeld = {
        { "Head", "TempleGuardHelmet" .. helmetType, "Helmet" },
        { "LeftHand", "LeftGloves", "Glove" },
        { "LeftLowerArm", "LeftLowerArm", "LowerArm" },
        { "LeftUpperArm", "LeftUpperSleeve", "UpperArm" },
        { "UpperTorso", "ChestPiece", "ChestPiece" },
        { "UpperTorso", "ChestPieceOver", "ChestPieceOver" },
        { "RightUpperArm", "RightUpperSleeve", "UpperSleeve" },
        { "RightLowerArm", "RightLowerArm", "LowerArm" },
        { "LowerTorso", "Belt", "Belt" }
    }

    for _, partInfo in pairs(partsToWeld) do
        local bodyPart = character:WaitForChild(partInfo[1])
        local partClone = clothingFolder:WaitForChild(partInfo[2]):clone()
        local weld = Instance.new("WeldConstraint")

        partClone.Parent = character
        partClone.CFrame = bodyPart.CFrame
        weld.Parent = bodyPart
        weld.Part0 = bodyPart
        weld.Part1 = partClone

        bodyPart.Transparency = 1
    end

    character:WaitForChild("Shirt").ShirtTemplate = "http://www.roblox.com/asset/?id=407652190"
    character:WaitForChild("Pants").PantsTemplate = "http://www.roblox.com/asset/?id=407652260"
end

Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function(addedCharacter)
        wait(0.45)

        if Player.Team == game.Teams["Temple Guard"] then
            local rank = Player:GetRankInGroup(34460815)

            if rank <= 5 then
                for _, accessory in pairs(addedCharacter:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        accessory:Destroy()
                    end
                end

                applyClothing(addedCharacter, "TempleGuard", "[Hood]")
            elseif rank >= 6 then
                for _, accessory in pairs(addedCharacter:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        accessory:Destroy()
                    end
                end

                applyClothing(addedCharacter, "TempleGuard", "[No-Hood]")
            end
        end
    end)
end)
