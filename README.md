# 🎨 Zinc Library Documentation

**Version:** 1.0.1 
**Author:** obemahavedih-tech
**License:** MIT

Welcome to the Zinc Library documentation! Zinc is a modern, lightweight UI library for Roblox client-side executors with a focus on clean design, smooth animations, and ease of use.

---

## 📦 Installation

### Loading the Library

```lua
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/1kJf0GJD"))()
```

> **Note:** Make sure you have a stable internet connection when loading the library.

---

## 🎯 Quick Start

Here's a simple example to get you started:

```lua
-- Load the library
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/1kJf0GJD"))()

-- Create a window
local Window = Library:CreateWindow({
    Name = "My First UI",
    Theme = "Dark"
})

-- Create a tab
local Tab = Window:CreateTab("Main")

-- Add a button
Tab:CreateButton({
    Name = "Click Me!",
    Callback = function()
        print("Button clicked!")
    end
})
```

---

## 🪟 Creating Windows

### Syntax

```lua
local Window = Library:CreateWindow(config)
```

### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Name` | string | The title displayed in the window header | `"UI Library"` |
| `Theme` | string | The color theme (`"Dark"`, `"Serenity"`, `"Forest"`) | `"Dark"` |

### Example

```lua
local Window = Library:CreateWindow({
    Name = "My Executor Hub",
    Theme = "Dark"
})
```

### Available Themes

#### Dark Theme
- Modern dark theme with blue accents
- Best for nighttime use
- Default theme

```lua
Theme = "Dark"
```

#### Serenity Theme
- Clean white/light theme
- Great for daytime use
- Professional appearance

```lua
Theme = "Serenity"
```

#### Forest Theme
- Nature-inspired green theme
- Easy on the eyes
- Unique aesthetic

```lua
Theme = "Forest"
```

#### Mocha Theme ✨ NEW
- Warm earthy tones
- Neutrals like cream and beige
- Sage and terracotta accents
- Comfortable and sophisticated

```lua
Theme = "Mocha"
```

#### Crimson Theme ✨ NEW
- Bold red accents
- Dark dramatic background
- High contrast
- Eye-catching design

```lua
Theme = "Crimson"
```

---

## 📑 Creating Tabs

Tabs help organize your UI into different sections.

### Syntax

```lua
local Tab = Window:CreateTab(name)
```

### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `name` | string | The name of the tab | `"Tab"` |

### Example

```lua
local MainTab = Window:CreateTab("Main")
local SettingsTab = Window:CreateTab("Settings")
local PlayerTab = Window:CreateTab("Player")
```

---

## 🔘 Components

### Buttons

Buttons execute a callback function when clicked.

#### Syntax

```lua
Tab:CreateButton(config)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Name` | string | The text displayed on the button | `"Button"` |
| `Callback` | function | Function to execute when clicked | `function() end` |

#### Example

```lua
Tab:CreateButton({
    Name = "Print Hello",
    Callback = function()
        print("Hello, World!")
    end
})
```

#### Advanced Example

```lua
Tab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
    end
})
```

---

### Toggles

Toggles are switches that can be turned on or off.

#### Syntax

```lua
local Toggle = Tab:CreateToggle(config)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Name` | string | The text displayed next to the toggle | `"Toggle"` |
| `Default` | boolean | Initial state of the toggle | `false` |
| `Callback` | function | Function called when toggle changes (receives boolean value) | `function() end` |

#### Example

```lua
Tab:CreateToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(value)
        print("ESP is now:", value)
        if value then
            -- Enable ESP
        else
            -- Disable ESP
        end
    end
})
```

#### Advanced Example with SetValue

```lua
local SpeedToggle = Tab:CreateToggle({
    Name = "Speed Boost",
    Default = false,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if value then
                player.Character.Humanoid.WalkSpeed = 100
            else
                player.Character.Humanoid.WalkSpeed = 16
            end
        end
    end
})

-- Programmatically set the toggle value
SpeedToggle:SetValue(true)
```

---

### Sliders

Sliders allow users to select a numeric value within a range.

#### Syntax

```lua
local Slider = Tab:CreateSlider(config)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Name` | string | The text displayed above the slider | `"Slider"` |
| `Range` | table | `{min, max}` values for the slider | `{0, 100}` |
| `Default` | number | Initial value of the slider | `Range[1]` |
| `Callback` | function | Function called when value changes (receives number value) | `function() end` |

#### Example

```lua
Tab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 200},
    Default = 16,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})
```

#### Advanced Example with SetValue

```lua
local FOVSlider = Tab:CreateSlider({
    Name = "Field of View",
    Range = {70, 120},
    Default = 70,
    Callback = function(value)
        workspace.CurrentCamera.FieldOfView = value
    end
})

-- Programmatically set the slider value
FOVSlider:SetValue(90)
```

---

### Text Inputs

Text inputs allow users to enter text data.

#### Syntax

```lua
local TextInput = Tab:CreateTextInput(config)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Name` | string | The label displayed above the input box | `"Input"` |
| `PlaceholderText` | string | Placeholder text shown when empty | `"Enter text..."` |
| `Callback` | function | Function called when Enter is pressed (receives string value) | `function() end` |

#### Example

```lua
Tab:CreateTextInput({
    Name = "Player Name",
    PlaceholderText = "Enter username...",
    Callback = function(text)
        print("You entered:", text)
    end
})
```

#### Advanced Example with Methods

```lua
local UsernameInput = Tab:CreateTextInput({
    Name = "Target Player",
    PlaceholderText = "Enter player name...",
    Callback = function(text)
        local player = game.Players:FindFirstChild(text)
        if player then
            print("Found player:", player.Name)
        else
            print("Player not found!")
        end
    end
})

-- Get current text
local currentText = UsernameInput:GetText()

-- Set text programmatically
UsernameInput:SetText("NewUsername")
```

---

### Labels

Labels display static or dynamic text information.

#### Syntax

```lua
local Label = Tab:CreateLabel(config)
```

#### Parameters

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `Text` | string | The text to display | `"Label"` |

#### Example

```lua
Tab:CreateLabel({
    Text = "Welcome to my script!"
})
```

#### Advanced Example with SetText

```lua
local StatusLabel = Tab:CreateLabel({
    Text = "Status: Idle"
})

-- Update the label text dynamically
StatusLabel:SetText("Status: Running")

-- Example: Dynamic FPS counter
local FPSLabel = Tab:CreateLabel({
    Text = "FPS: Calculating..."
})

spawn(function()
    local lastUpdate = tick()
    local frames = 0
    
    game:GetService("RunService").RenderStepped:Connect(function()
        frames = frames + 1
        
        if tick() - lastUpdate >= 1 then
            FPSLabel:SetText("FPS: " .. tostring(frames))
            frames = 0
            lastUpdate = tick()
        end
    end)
end)
```

---

## 🎨 Complete Example

Here's a comprehensive example showcasing all features:

```lua
-- Load library
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/1kJf0GJD"))()

-- Create window
local Window = Library:CreateWindow({
    Name = "Complete Example",
    Theme = "Dark"
})

-- Main Tab
local MainTab = Window:CreateTab("Main")

MainTab:CreateLabel({
    Text = "Welcome to the complete example!"
})

MainTab:CreateButton({
    Name = "Test Button",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Button Clicked",
            Text = "The button was pressed!",
            Duration = 3
        })
    end
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player")

PlayerTab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 100},
    Default = 16,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(value)
        _G.InfiniteJump = value
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Settings Tab
local SettingsTab = Window:CreateTab("Settings")

SettingsTab:CreateTextInput({
    Name = "Custom Message",
    PlaceholderText = "Enter message...",
    Callback = function(text)
        print("Message:", text)
    end
})

local StatusLabel = SettingsTab:CreateLabel({
    Text = "Status: Ready"
})

SettingsTab:CreateButton({
    Name = "Update Status",
    Callback = function()
        StatusLabel:SetText("Status: Updated at " .. os.date("%X"))
    end
})
```

---

## 🎯 Best Practices

### 1. **Organize with Tabs**
Group related features into separate tabs for better organization.

```lua
local CombatTab = Window:CreateTab("Combat")
local MovementTab = Window:CreateTab("Movement")
local VisualsTab = Window:CreateTab("Visuals")
```

### 2. **Use Descriptive Names**
Make button and toggle names clear and descriptive.

```lua
-- Good
Tab:CreateButton({Name = "Reset Character"})

-- Bad
Tab:CreateButton({Name = "Reset"})
```

### 3. **Handle Errors**
Always use pcall for callbacks that might fail.

```lua
Tab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local success, err = pcall(function()
            -- Your teleport code here
        end)
        
        if not success then
            warn("Teleport failed:", err)
        end
    end
})
```

### 4. **Store References**
Store references to components you need to update dynamically.

```lua
local SpeedSlider = Tab:CreateSlider({
    Name = "Speed",
    Range = {0, 100},
    Default = 50,
    Callback = function(value) end
})

-- Later in your code
SpeedSlider:SetValue(75)
```

### 5. **Clean Up Connections**
Disconnect events when toggles are turned off.

```lua
local connection

Tab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value)
        if value then
            connection = game:GetService("RunService").Heartbeat:Connect(function()
                -- Auto farm logic
            end)
        else
            if connection then
                connection:Disconnect()
            end
        end
    end
})
```

---

## 🔧 Component Methods Reference

### Toggle Methods

```lua
local Toggle = Tab:CreateToggle({...})

-- Set the toggle state programmatically
Toggle:SetValue(true)  -- Enable
Toggle:SetValue(false) -- Disable
```

### Slider Methods

```lua
local Slider = Tab:CreateSlider({...})

-- Set the slider value programmatically
Slider:SetValue(50)
```

### TextInput Methods

```lua
local Input = Tab:CreateTextInput({...})

-- Get the current text
local text = Input:GetText()

-- Set the text programmatically
Input:SetText("New text")
```

### Label Methods

```lua
local Label = Tab:CreateLabel({...})

-- Update the label text
Label:SetText("New label text")
```

---

## 🎨 Theme Colors Reference

### Dark Theme
- **Background:** `RGB(20, 20, 25)`
- **Secondary:** `RGB(30, 30, 35)`
- **Accent:** `RGB(70, 130, 255)` (Blue)
- **Text:** `RGB(240, 240, 245)`
- **Border:** `RGB(50, 50, 60)`

### Serenity Theme
- **Background:** `RGB(245, 245, 250)`
- **Secondary:** `RGB(255, 255, 255)`
- **Accent:** `RGB(100, 150, 255)` (Light Blue)
- **Text:** `RGB(30, 30, 35)`
- **Border:** `RGB(220, 220, 230)`

### Forest Theme
- **Background:** `RGB(25, 35, 30)`
- **Secondary:** `RGB(35, 45, 40)`
- **Accent:** `RGB(80, 200, 120)` (Green)
- **Text:** `RGB(240, 245, 240)`
- **Border:** `RGB(50, 70, 60)`

---

## 🐛 Troubleshooting

### Library fails to load
**Problem:** `attempt to index nil with 'CreateWindow'`

**Solution:** Make sure the library code has `return Library` at the end.

### Components not appearing
**Problem:** Tabs or components are invisible

**Solution:** Ensure you're creating components under the correct tab and the window has been created.

### Callbacks not firing
**Problem:** Functions not executing when buttons are clicked

**Solution:** Check that your callback function is properly defined and doesn't have syntax errors.

### Window not draggable
**Problem:** Can't move the window

**Solution:** The window should be draggable by the header. Make sure you're clicking and dragging the top bar.

---

## 📝 Changelog

### Version 1.0.1
- Initial release
- Added Mocha,Crimson Themes
- Implemented core components: Button, Toggle, Slider, TextInput, Label also added dropdown menus and notifs
- Added draggable window functionality
- Implemented tab system
- Added minimize/maximize animation
- Mobile-friendly touch support

---

## 🤝 Contributing

If you'd like to contribute to Zinc Library or report bugs:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## 📄 License

MIT License - Feel free to use this library in your projects!

---

## 💬 Support

For support, questions, or feature requests:
- Open an issue on GitHub
- Contact via Discord: [Your Discord]
- Join our community: [Your Server]

---

## 🌟 Credits

Created with ❤️ by [Your Name]

Special thanks to all contributors and testers!

---

**Happy Scripting! 🚀**
