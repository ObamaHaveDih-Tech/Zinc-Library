# 🚀 Zinc Library - Quick Reference Guide

## 📌 Loading the Library

```lua
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/1kJf0GJD"))()
```

---

## 🪟 Create Window

```lua
local Window = Library:CreateWindow({
    Name = "Window Title",
    Theme = "Dark" -- Dark, Serenity, Forest, Mocha, Crimson
})
```

---

## 📑 Create Tab

```lua
local Tab = Window:CreateTab("Tab Name")
```

---

## 🔔 Send Notification

```lua
Window:Notify({
    Title = "Title",
    Message = "Message text",
    Duration = 3,
    Type = "Info" -- Info, Success, Warning, Error
})
```

---

## 🔘 Button

```lua
Tab:CreateButton({
    Name = "Button Text",
    Callback = function()
        -- Your code here
    end
})
```

---

## 🔄 Toggle

```lua
local Toggle = Tab:CreateToggle({
    Name = "Toggle Name",
    Default = false,
    Callback = function(value)
        print(value) -- true or false
    end
})

-- Methods
Toggle:SetValue(true)
```

---

## 📊 Slider

```lua
local Slider = Tab:CreateSlider({
    Name = "Slider Name",
    Range = {0, 100},
    Default = 50,
    Callback = function(value)
        print(value) -- Number between range
    end
})

-- Methods
Slider:SetValue(75)
```

---

## 📝 Text Input

```lua
local Input = Tab:CreateTextInput({
    Name = "Input Name",
    PlaceholderText = "Enter text...",
    Callback = function(text)
        print(text) -- String value
    end
})

-- Methods
local text = Input:GetText()
Input:SetText("New text")
```

---

## 📋 Dropdown

```lua
local Dropdown = Tab:CreateDropdown({
    Name = "Dropdown Name",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(value)
        print(value) -- Selected option
    end
})

-- Methods
Dropdown:SetValue("Option 2")
local selected = Dropdown:GetValue()
Dropdown:Refresh({"New", "Options", "List"})
```

---

## 🏷️ Label

```lua
local Label = Tab:CreateLabel({
    Text = "Label text"
})

-- Methods
Label:SetText("New text")
```

---

## 🎨 Available Themes

| Theme | Description |
|-------|-------------|
| `Dark` | Modern dark with blue accents (default) |
| `Serenity` | Clean white/light theme |
| `Forest` | Nature-inspired green |
| `Mocha` | Warm earthy tones |
| `Crimson` | Bold red theme |

---

## 💡 Common Patterns

### Player Modification
```lua
local player = game.Players.LocalPlayer
if player.Character and player.Character:FindFirstChild("Humanoid") then
    player.Character.Humanoid.WalkSpeed = 50
end
```

### Toggling Features
```lua
local enabled = false
Tab:CreateToggle({
    Name = "Feature",
    Default = false,
    Callback = function(value)
        enabled = value
        if enabled then
            -- Enable logic
        else
            -- Disable logic
        end
    end
})
```

### Dynamic Dropdowns
```lua
local playerList = {}
for _, player in pairs(game.Players:GetPlayers()) do
    table.insert(playerList, player.Name)
end

local Dropdown = Tab:CreateDropdown({
    Name = "Players",
    Options = playerList,
    Default = playerList[1],
    Callback = function(value) end
})

-- Update when players join/leave
game.Players.PlayerAdded:Connect(function()
    -- Refresh dropdown
end)
```

### Updating Labels Dynamically
```lua
local Label = Tab:CreateLabel({Text = "Status: Idle"})

spawn(function()
    while wait(1) do
        Label:SetText("Time: " .. os.date("%X"))
    end
end)
```

### Error Handling
```lua
Tab:CreateButton({
    Name = "Safe Action",
    Callback = function()
        local success, err = pcall(function()
            -- Your code here
        end)
        
        if success then
            Window:Notify({
                Title = "Success",
                Message = "Action completed",
                Duration = 2,
                Type = "Success"
            })
        else
            Window:Notify({
                Title = "Error",
                Message = "Action failed: " .. tostring(err),
                Duration = 4,
                Type = "Error"
            })
        end
    end
})
```

---

## ⚡ Performance Tips

1. **Use `spawn()` or `task.spawn()` for loops**
```lua
spawn(function()
    while task.wait(1) do
        -- Update code
    end
end)
```

2. **Store references to frequently updated components**
```lua
local StatusLabel = Tab:CreateLabel({Text = "Status"})
-- Much better than recreating each time
```

3. **Disconnect connections when toggles are off**
```lua
local connection
Toggle:Callback(function(value)
    if value then
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            -- Code
        end)
    else
        if connection then
            connection:Disconnect()
        end
    end
end)
```

4. **Batch notifications instead of spamming**
```lua
-- Bad: Multiple instant notifications
-- Good: Delayed or single summary notification
```

---

## 🎯 Complete Template

```lua
-- Load library
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/1kJf0GJD"))()

-- Create window
local Window = Library:CreateWindow({
    Name = "My Script Hub",
    Theme = "Dark"
})

-- Create tab
local MainTab = Window:CreateTab("Main")

-- Add components
MainTab:CreateLabel({Text = "Welcome!"})

MainTab:CreateButton({
    Name = "Click Me",
    Callback = function()
        Window:Notify({
            Title = "Clicked",
            Message = "Button was pressed",
            Duration = 2,
            Type = "Success"
        })
    end
})

MainTab:CreateToggle({
    Name = "Feature",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

MainTab:CreateSlider({
    Name = "Value",
    Range = {0, 100},
    Default = 50,
    Callback = function(value)
        print("Slider:", value)
    end
})

MainTab:CreateDropdown({
    Name = "Options",
    Options = {"A", "B", "C"},
    Default = "A",
    Callback = function(value)
        print("Selected:", value)
    end
})

-- Final notification
Window:Notify({
    Title = "Loaded",
    Message = "Script ready!",
    Duration = 3,
    Type = "Success"
})
```

---

## 🔗 Useful Resources

- **Full Documentation:** See README.md
- **Demo Script:** Example implementation
- **Advanced Examples:** Complex usage patterns
- **GitHub:** [Your Repository Link]

---

## 📞 Support

- **Issues:** Report on GitHub
- **Discord:** [Your Server]
- **Updates:** Follow repository for new features

---

**Made with ❤️ using Zinc Library**
