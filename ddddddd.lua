local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local PhantomForcesWindow = Library:NewWindow("Chaos Loop | zRxTeam ")

local KillingCheats = PhantomForcesWindow:NewSection("Main Options")

local UserInputService = game:GetService("UserInputService")
local Heartbeat = game:GetService("RunService").Heartbeat
local dupping = false
local walkSpeed = 16.5
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
                plr.Character.Humanoid.WalkSpeed = walkSpeed+16
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

KillingCheats:CreateButton("Hitlock (For Sword Only)", function()
plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'r' then
        tar = nil
        for _,v in next,workspace:GetDescendants() do
            if v.Name == 'SelectedPlayer' then
                v:Destroy()
            end
        end
        local n_plr, dist
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and plr.Character and plr.Character:FindFirstChild'HumanoidRootPart' then
                local distance = v:DistanceFromCharacter(plr.Character.HumanoidRootPart.Position)
                if v.Character and (not dist or distance <= dist) and v.Character:FindFirstChildOfClass'Humanoid' and v.Character:FindFirstChildOfClass'Humanoid'.Health>0 and v.Character:FindFirstChild'HumanoidRootPart' then
                    dist = distance
                    n_plr = v
                end
            end
        end
        local sp = Instance.new('SelectionBox',n_plr.Character.Torso)
        sp.Name = 'SelectedPlayer'
        sp.Adornee = n_plr.Character.HumanoidRootPart
        sp.Color3 = Color3.new(255, 0, 0)
        sp.Transparency = 0.45
        tar = n_plr
    elseif key == 'q' and tar and plr.Character then
        for _,v in next,plr.Character:GetDescendants() do
            if v:IsA'Tool' and v.Name ~= 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'DamageRemote' and v:FindFirstChild'Cooldown' and tar and tar.Character and tar.Character:FindFirstChildOfClass'Humanoid' then
                AddCd(v,v.Cooldown.Value)
                if v:FindFirstChild'Attack' and plr.Character:FindFirstChildOfClass'Humanoid' then
                    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Attack):Play()
                end
Workspace.Brxyns:FindFirstChild('Emerald Greatsword').Blade.SwingSound:Play()
                wait(.2)
Workspace.Brxyns:FindFirstChild('Emerald Greatsword').Blade.HitSound:Play()
rs.Stepped:Wait() --LOLLLL Fixed.
                v.DamageRemote:FireServer(tar.Character:FindFirstChildOfClass'Humanoid')
            elseif v:IsA'Tool' and v.Name == 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'ReplicateRemote' and v:FindFirstChild'Barrel' and v.Barrel:FindFirstChild'Attachment' and tar and tar.Character and tar.Character:FindFirstChild'Head' then
                v.Parent = plr.Character
                AddCd(v,2)
                rs.Stepped:wait()
                plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Fire):Play()
                Shoot(v.Barrel.Attachment.WorldPosition,tar.Character:WaitForChild("Head").Position,v)
                v.ReplicateRemote:FireServer(tar.Character:WaitForChild("Head").Position)            
            end
        end
    end
end)



plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'z' and tar and plr.Character then 
        for _,v in next,plr.Character:GetDescendants() do
            if v:IsA'Tool' and v.Name ~= 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'DamageRemote' and v:FindFirstChild'Cooldown' and tar and tar.Character and tar.Character:FindFirstChildOfClass'Humanoid' then
                AddCd(v,v.Cooldown.Value)
                  Workspace.Brxyns:WaitForChild('Emerald Greatsword').Blade.HitSound:Play()
rs.Stepped:Wait() --LOLLLL Fixed.
v.DamageRemote:FireServer(tar.Character:FindFirstChildOfClass'Humanoid')          
            end
        end
   end
 
end)

plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'x' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'Grenade' then
                pcall(function()
                    v.Parent = plr.Character
    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Throw):Play()     
                    v:Activate(mouse.Hit.LookVector)
                    mouse2click()
                    wait()
                end)
            end
        end
end
end)



plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'g' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'Grenade 2' then
                    v.Parent = plr.Character   
                    wait() 
                    v:Activate()
            end
        end
end
end)

plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'b' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'C4' then
                pcall(function()
                    v.Parent = plr.Character
    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Throw):Play()     
                    v:Activate(mouse.Hit.LookVector)
                    mouse2click()
                    wait()
                end)
            end
        end
end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Emerald Greatsword" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Chainsaw" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Pencil" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Blood Dagger" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)


game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Target)
local A_1 = game:GetService("Workspace"):WaitForChild("HelloJesus009").Humanoid
        local Target = A_1
           repeat
               wait()
local Event = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1)
          until Target.Health <= 0
Event:FireServer(A_1)
end
end)


game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadFive then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Target)
local A_1 = game:GetService("Workspace"):WaitForChild("HelloJesus009").Humanoid
        local Target = A_1
           repeat
               wait()
local Event = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1)
          until Target.Health <= 0
Event:FireServer(A_1)
end
end)
end)

KillingCheats:CreateButton("Hitlock v7!", function()
plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'r' then
        tar = nil
        for _,v in next,workspace:GetDescendants() do
            if v.Name == 'SelectedPlayer' then
                v:Destroy()
            end
        end
        local n_plr, dist
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= plr and plr.Character and plr.Character:FindFirstChild'HumanoidRootPart' then
                local distance = v:DistanceFromCharacter(plr.Character.HumanoidRootPart.Position)
                if v.Character and (not dist or distance <= dist) and v.Character:FindFirstChildOfClass'Humanoid' and v.Character:FindFirstChildOfClass'Humanoid'.Health>0 and v.Character:FindFirstChild'HumanoidRootPart' then
                    dist = distance
                    n_plr = v
                end
            end
        end
        local sp = Instance.new('SelectionBox',n_plr.Character.Torso)
        sp.Name = 'SelectedPlayer'
        sp.Adornee = n_plr.Character.HumanoidRootPart
        sp.Color3 = Color3.new(255, 0, 0)
        sp.Transparency = 0.45
        tar = n_plr
    elseif key == 'q' and tar and plr.Character then
        for _,v in next,plr.Character:GetDescendants() do
            if v:IsA'Tool' and v.Name ~= 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'DamageRemote' and v:FindFirstChild'Cooldown' and tar and tar.Character and tar.Character:FindFirstChildOfClass'Humanoid' then
                AddCd(v,v.Cooldown.Value)
                if v:FindFirstChild'Attack' and plr.Character:FindFirstChildOfClass'Humanoid' then
                    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Attack):Play()
                end
                if v:FindFirstChild'Blade' then
                    for _,x in next,v.Blade:GetChildren() do
                        if x:IsA'Sound' then
                        wait(.1)
                            x:Play()
                        end
                    end
                end
rs.Stepped:Wait() --LOLLLL Fixed.
                v.DamageRemote:FireServer(tar.Character:FindFirstChildOfClass'Humanoid')
            elseif v:IsA'Tool' and v.Name == 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'ReplicateRemote' and v:FindFirstChild'Barrel' and v.Barrel:FindFirstChild'Attachment' and tar and tar.Character and tar.Character:FindFirstChild'Head' then
                v.Parent = plr.Character
                AddCd(v,2)
                rs.Stepped:wait()
                plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Fire):Play()
                Shoot(v.Barrel.Attachment.WorldPosition,tar.Character:WaitForChild("Head").Position,v)
                v.ReplicateRemote:FireServer(tar.Character:WaitForChild("Head").Position)            
            end
        end
    end
end)



plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'z' and tar and plr.Character then 
        for _,v in next,plr.Character:GetDescendants() do
            if v:IsA'Tool' and v.Name ~= 'Kawaii Revolver' and not v:FindFirstChild'ClientCD' and v:FindFirstChild'DamageRemote' and v:FindFirstChild'Cooldown' and tar and tar.Character and tar.Character:FindFirstChildOfClass'Humanoid' then
                AddCd(v,v.Cooldown.Value)
                  Workspace.Brxyns:WaitForChild('Emerald Greatsword').Blade.HitSound:Play()
rs.Stepped:Wait() --LOLLLL Fixed.
v.DamageRemote:FireServer(tar.Character:FindFirstChildOfClass'Humanoid')          
            end
        end
   end
 
end)

plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'x' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'Grenade' then
                pcall(function()
                    v.Parent = plr.Character
    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Throw):Play()     
                    v:Activate(mouse.Hit.LookVector)
                    mouse2click()
                    wait()
                end)
            end
        end
end
end)



plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'g' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'Grenade 2' then
                    v.Parent = plr.Character   
                    wait() 
                    v:Activate()
            end
        end
end
end)

plr:GetMouse().KeyDown:Connect(function(key)
    if key == 'b' then
        for _,v in next,plr.Backpack:GetChildren() do
            if v.Name == 'C4' then
                pcall(function()
                    v.Parent = plr.Character
    plr.Character:FindFirstChildOfClass'Humanoid':LoadAnimation(v.Throw):Play()     
                    v:Activate(mouse.Hit.LookVector)
                    mouse2click()
                    wait()
                end)
            end
        end
end
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Hitlock";
    Text = "Cargada correctamente!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callbakc = bindableFunction;
})

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Emerald Greatsword" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Chainsaw" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Pencil" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.Name == "Blood Dagger" then
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                for i=1,2 do
					game:GetService("RunService").Heartbeat:Wait()
				end
			end
		end
    end
end)


game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Clear then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Target)
local A_1 = game:GetService("Workspace"):WaitForChild("Brxyns").Humanoid
        local Target = A_1
           repeat
               wait()
local Event = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1)
          until Target.Health <= 0
Event:FireServer(A_1)
end
end)


game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadFive then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Target)
local A_1 = game:GetService("Workspace"):WaitForChild("Brxyns").Humanoid
        local Target = A_1
           repeat
               wait()
local Event = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1)
          until Target.Health <= 0
Event:FireServer(A_1)
end
end)
end)

KillingCheats:CreateDropdown("DropDown", {"Mace", "Chainsaw", "Knife", "Pan", "Pencil", "Baseball Bat", "Scythe", "Emerald Greatsword", "Blood Dagger", "Frost Spear"}, 2, function(weapon)
local Mouse = game.Players.LocalPlayer:GetMouse()
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.Z then
while true do wait()
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()


	game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Menu Screen").Enabled = false
    Player.PlayerGui["Menu Screen"].RemoteEvent:FireServer(weapon)
wait(1) end
end
end)

local function Notify(title,text,duration)
    game:GetService'StarterGui':SetCore('SendNotification',{
        Title = tostring(title),
        Text = tostring(text),
        Duration = tonumber(duration),
    })
end

game.StarterGui:SetCore("SendNotification", {
    Title = "Auto Choose";
    Text = (weapon);
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callbakc = bindableFunction;
})
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "GUI";
    Text = "Bienvenido mono";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callbakc = bindableFunction;
})


KillingCheats:CreateButton("Activate All Spikes!", function()
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadTwo then	
	for _,v in pairs(workspace:GetDescendants()) do
		if v:IsA("TouchTransmitter") then
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, -0) --0 is touch
			task.wait(.01)
			firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1) -- 1 is untouch
		end
	end
end
end)
end)

KillingCheats:CreateButton("Infinite Yield", function()
loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
end)

KillingCheats:CreateTextbox("Type target username.", function(Player)
game.StarterGui:SetCore("SendNotification", {
    Title = (Player);
    Text = "Was choosed. Now Click - To Kill!";
    Icon = "http://www.roblox.com/asset/?id=12790890422";
    Duration = "DURATION IN SECONDS";
    callback = bindableFunction;
})
game:GetService("UserInputService").InputBegan:Connect(function(Input, IsTyping)
if IsTyping then return end
if Input.KeyCode == Enum.KeyCode.KeypadMinus then
game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(Target)
local A_1 = game:GetService("Workspace"):WaitForChild(Player).Humanoid
        local Target = A_1
           repeat
               wait()
local Event = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool").DamageRemote:FireServer(A_1)
          until Target.Health <= 0
Event:FireServer(A_1)
end
end)
end)

KillingCheats:CreateToggle("Autoclick -", function(ok)
while true do wait() game:GetService("VirtualInputManager"):SendKeyEvent(true,Enum.KeyCode.KeypadMinus,false,game)(ok) wait(1) end
end)