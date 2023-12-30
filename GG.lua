local UserInputService = game:GetService("UserInputService")
local Heartbeat = game:GetService("RunService").Heartbeat
local walkSpeed = 16
local plrs = game:GetService'Players'local UserInputService = game:GetService("UserInputService")
local Heartbeat = game:GetService("RunService").Heartbeat
local dupping = false
local plrs = game:GetService'Players'
local plr = plrs.LocalPlayer
local mouse = plr:GetMouse()
local rep = game:GetService'ReplicatedStorage'
local uis = game:GetService'UserInputService'
local ts = game:GetService'TweenService'
local rs = game:GetService'RunService'

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()

local function Notify(title,text,duration)
    game:GetService'StarterGui':SetCore('SendNotification',{
        Title = tostring(title),
        Text = tostring(text),
        Duration = tonumber(duration),
    })
end

local function GetChar()
    local Char = Player.Character or Player.CharacterAdded:Wait()
    return Char
end

spawn(function()
    while true do rs.RenderStepped:wait()
        pcall(function()
            if not uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                plr.Character.Humanoid.WalkSpeed = walkSpeed
            elseif uis:IsKeyDown(Enum.KeyCode.LeftShift) then
                plr.Character.Humanoid.WalkSpeed = walkSpeed+4
            end
        end)
    end
end)

spawn(function()
    while true do rs.RenderStepped:wait()
        pcall(function()
            if not uis:IsKeyDown(Enum.KeyCode.E) then
                plr.Character.Humanoid.WalkSpeed = walkSpeed
            elseif uis:IsKeyDown(Enum.KeyCode.E) then
                plr.Character.Humanoid.WalkSpeed = walkSpeed+7
            end
        end)
    end
end)

local function AddCd(tool,Cd)
    local cd = Instance.new('IntValue',tool)
    cd.Name = 'ClientCD'
    game.Debris:AddItem(cd,Cd)
end
local function Shoot(firstPos,nextPos,Revolver)
    if Revolver:FindFirstChild'Barrel' and Revolver.Barrel:FindFirstChild'Attachment' then
        if Revolver.Barrel.Attachment:FindFirstChild'Sound' then
            local SoundClone = Revolver.Barrel.Attachment.Sound:Clone()
            SoundClone.Name = 'Uncopy'
            SoundClone.Parent = Revolver.Barrel.Attachment
            SoundClone:Play()
            game.Debris:AddItem(SoundClone, 1)
        end
        local FilterTable = {}
        table.insert(FilterTable, plr.Character)
        table.insert(FilterTable, game.Workspace['Target Filter'])
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.ClassName == 'Accessory' then
                table.insert(FilterTable, v)
            end
        end
        local a_1, a_2, a_3 = game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(firstPos, (nextPos - firstPos).Unit * 100), FilterTable)
        local BulletCl = rep['Revolver Bullet']:Clone()
        game.Debris:AddItem(BulletCl, 1)
        BulletCl.Parent = game.Workspace['Target Filter']
        local mg = (firstPos - a_2).Magnitude
        BulletCl.Size = Vector3.new(0.2, 0.2, mg)
        BulletCl.CFrame = CFrame.new(firstPos, nextPos) * CFrame.new(0, 0, -mg / 2)
        ts:Create(BulletCl, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Size = Vector3.new(0.06, 0.06, mg), 
            Transparency = 1
        }):Play()
        if a_1 then
            local expPart = Instance.new'Part'
            game.Debris:AddItem(expPart, 2)
            expPart.Name = 'Exploding Neon Part'
            expPart.Anchored = true
            expPart.CanCollide = true
            expPart.Shape = 'Ball'
            expPart.Material = Enum.Material.Neon
            expPart.BrickColor = BulletCl.BrickColor
            expPart.Size = Vector3.new(0.1, 0.1, 0.1)
            expPart.Parent = game.Workspace['Target Filter']
            expPart.Position = a_2
            ts:Create(expPart, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Size = Vector3.new(2, 2, 2), 
                Transparency = 1
            }):Play()
            if Revolver:FindFirstChild'DamageRemote' and a_1.Parent:FindFirstChild'Humanoid' then
                Revolver.DamageRemote:FireServer(a_1.Parent.Humanoid)
            end
        end
    end
end


local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Txckz/Chaos-T1gger-v6/main/Gui", true))()
local Table = {}

local window = Lib:CreateWindow("CHAOS T1gger")
windows:section("Ez")

window:Button("Infinite Yield v5",function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

window:Dropdown("Select Target",{location = Table,flag = "player1",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player1"])
local A_1 = game:GetService("Workspace"):FindFirstChild(Table["player1"]).Humanoid
        local Target = A_1
           repeat
               wait()
local A_1 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

wait()

window:Dropdown("Select Target",{location = Table,flag = "player2",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player2"])
local A_2 = game:GetService("Workspace"):FindFirstChild(Table["player2"]).Humanoid
        local Target = A_2
           repeat
               wait()
local A_2 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_2) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

wait()

window:Dropdown("Select Target",{location = Table,flag = "player3",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player3"])
local A_3 = game:GetService("Workspace"):FindFirstChild(Table["player3"]).Humanoid
        local Target = A_3
           repeat
               wait()
local A_3 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_3) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

wait()

window:Dropdown("Select Target",{location = Table,flag = "player4",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player4"])
local A_4 = game:GetService("Workspace"):FindFirstChild(Table["player4"]).Humanoid
        local Target = A_4
           repeat
               wait()
local A_4 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_4) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

window:Dropdown("Select Target",{location = Table,flag = "player4",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player4"])
local A_4 = game:GetService("Workspace"):FindFirstChild(Table["player4"]).Humanoid
        local Target = A_4
           repeat
               wait()
local A_4 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_4) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

window:Dropdown("Select Target",{location = Table,flag = "player4",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player4"])
local A_4 = game:GetService("Workspace"):FindFirstChild(Table["player4"]).Humanoid
        local Target = A_4
           repeat
               wait()
local A_4 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_4) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

window:Dropdown("Select Target",{location = Table,flag = "player4",search = true --[[AddsSearchBar]], list = {"Mace","Chainsaw","Knife","Pan","Pencil","Baseball Bat","Scythe","Emerald Greatsword","Blood Dagger"} --[[Wont work when PlayerList = true]], PlayerList = true --[[ Turns the list into the players in the server ]]},function()game.StarterGui:SetCore("SendNotification", {
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Table["player4"])
local A_4 = game:GetService("Workspace"):FindFirstChild(Table["player4"]).Humanoid
        local Target = A_4
           repeat
               wait()
local A_4 = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_4) and not v:FindFirstChild("ForceField")
          until Target.Health <= 0
end
end)
end)

local Pressing = false
window:Toggle("Autopress Kill Key (-)",{location = Table, flag = "enable"},function()
    if Pressing then
        Pressing = false
    else
        Pressing = true
        repeat
        wait()
game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.KeypadMinus,false,game) wait(1)
            game:GetService("RunService").Heartbeat:Wait()
        until not Pressing
    end

end)


local FastKilling = false

window:Button("Quick God",function()
game:GetService("Players").LocalPlayer.Character.PickupRemote:FireServer()
wait(.5)
game.Players.LocalPlayer.Character["Torso"]:Destroy()
wait(.2)
game.Players.LocalPlayer.Character["Humanoid"]:Destroy()
end)

window:Button("Pencil Tp (Click)",function()
local UIS = game:GetService("UserInputService")

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()


function GetCharacter()
   return Workspace.Elekt0r.Pencil
end

function Teleport(pos)
   local Tool = GetCharacter()
   if Tool then
       Tool:MoveTo(pos)
   end
end


UIS.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and Enum.KeyCode.Z then
       Teleport(Mouse.Hit.p)
   end
end)
end)