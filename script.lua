-- AUTO JOINER UI - DEMO
-- Filtre les exemples SECRET et MYTHIC
-- Les données sont fictives : aucun vrai serveur n'est rejoint.

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "AutoJoinerPanel"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 560, 0, 350)
main.Position = UDim2.new(0.5, -280, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(15, 17, 25)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 45)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SAB AUTO JOINER"
title.TextColor3 = Color3.fromRGB(120, 145, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 35, 0, 30)
close.Position = UDim2.new(1, -43, 0, 7)
close.Text = "X"
close.Parent = main

close.Activated:Connect(function()
    gui:Destroy()
end)

local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -30, 0, 35)
search.Position = UDim2.new(0, 15, 0, 52)
search.PlaceholderText = "Search rare Brainrots..."
search.Text = ""
search.ClearTextOnFocus = false
search.Parent = main

-- EXEMPLES FICTIFS
local examples = {
    {name = "Player_01", brainrot = "Secret Brainrot", rarity = "SECRET"},
    {name = "Player_02", brainrot = "Lucky Brainrot", rarity = "MYTHIC"},
    {name = "Player_03", brainrot = "Common Brainrot", rarity = "COMMON"},
    {name = "Player_04", brainrot = "Rare Brainrot", rarity = "RARE"},
}

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -30, 0, 190)
list.Position = UDim2.new(0, 15, 0, 95)
list.BackgroundColor3 = Color3.fromRGB(21, 24, 35)
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.Parent = list

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 7)
padding.PaddingLeft = UDim.new(0, 7)
padding.PaddingRight = UDim.new(0, 7)
padding.Parent = list

local function refreshList(query)
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local count = 0
    query = (query or ""):lower()

    for _, data in ipairs(examples) do
        local rare = data.rarity == "SECRET"
            or data.rarity == "MYTHIC"

        local searchable = (
            data.name .. " " ..
            data.brainrot .. " " ..
            data.rarity
        ):lower()

        if rare and searchable:find(query, 1, true) then
            count += 1

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, -5, 0, 45)
            row.BackgroundColor3 = Color3.fromRGB(32, 36, 51)
            row.BorderSizePixel = 0
            row.LayoutOrder = count
            row.Parent = list

            Instance.new("UICorner", row).CornerRadius =
                UDim.new(0, 6)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -85, 1, 0)
            label.Position = UDim2.new(0, 8, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = data.name .. " | " .. data.brainrot
            label.TextColor3 = Color3.new(1, 1, 1)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = row

            local join = Instance.new("TextButton")
            join.Size = UDim2.new(0, 65, 0, 28)
            join.Position = UDim2.new(1, -72, 0.5, -14)
            join.BackgroundColor3 = Color3.fromRGB(65, 100, 230)
            join.Text = "JOIN"
            join.TextColor3 = Color3.new(1, 1, 1)
            join.Font = Enum.Font.GothamBold
            join.TextSize = 11
            join.Parent = row

            join.Activated:Connect(function()
                print("Démo : joueur sélectionné - " .. data.name)
            end)
        end
    end

    list.CanvasSize = UDim2.new(0, 0, 0, count * 51 + 10)
end

search:GetPropertyChangedSignal("Text"):Connect(function()
    refreshList(search.Text)
end)

refreshList("")
