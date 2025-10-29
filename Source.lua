--[[
    Modern UI Library for Roblox Client-Side Executors
    Version: 1.1.0
    
    Features:
    - Multiple theme support (Dark, Serenity, Forest, Mocha, Crimson)
    - Draggable window with mobile support
    - Tab system for organized content
    - Interactive elements (Buttons, Toggles, Sliders, Dropdowns, Text Inputs, Labels)
    - Custom notification system
    - Smooth animations and transitions
    - Responsive design using Scale values
]]

local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Theme Definitions
local Themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 25),
        Secondary = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(70, 130, 255),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(50, 50, 60),
        Hover = Color3.fromRGB(40, 40, 50)
    },
    Serenity = {
        Background = Color3.fromRGB(245, 245, 250),
        Secondary = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(100, 150, 255),
        Text = Color3.fromRGB(30, 30, 35),
        SubText = Color3.fromRGB(100, 100, 110),
        Border = Color3.fromRGB(220, 220, 230),
        Hover = Color3.fromRGB(235, 235, 245)
    },
    Forest = {
        Background = Color3.fromRGB(25, 35, 30),
        Secondary = Color3.fromRGB(35, 45, 40),
        Accent = Color3.fromRGB(80, 200, 120),
        Text = Color3.fromRGB(240, 245, 240),
        SubText = Color3.fromRGB(180, 190, 180),
        Border = Color3.fromRGB(50, 70, 60),
        Hover = Color3.fromRGB(45, 55, 50)
    },
    Mocha = {
        Background = Color3.fromRGB(235, 230, 220),
        Secondary = Color3.fromRGB(245, 240, 235),
        Accent = Color3.fromRGB(133, 116, 101),
        Text = Color3.fromRGB(60, 50, 45),
        SubText = Color3.fromRGB(120, 110, 100),
        Border = Color3.fromRGB(200, 190, 180),
        Hover = Color3.fromRGB(225, 215, 205)
    },
    Crimson = {
        Background = Color3.fromRGB(25, 15, 20),
        Secondary = Color3.fromRGB(35, 20, 25),
        Accent = Color3.fromRGB(220, 50, 70),
        Text = Color3.fromRGB(245, 240, 240),
        SubText = Color3.fromRGB(190, 170, 175),
        Border = Color3.fromRGB(80, 40, 50),
        Hover = Color3.fromRGB(50, 30, 35)
    },
    Ocean = {
        Background = Color3.fromRGB(10, 20, 30),
        Secondary = Color3.fromRGB(15, 30, 45),
        Accent = Color3.fromRGB(50, 150, 200),
        Text = Color3.fromRGB(230, 240, 245),
        SubText = Color3.fromRGB(150, 180, 200),
        Border = Color3.fromRGB(30, 60, 90),
        Hover = Color3.fromRGB(20, 35, 50)
    },
    Royal = {
        Background = Color3.fromRGB(10, 10, 15),
        Secondary = Color3.fromRGB(20, 20, 30),
        Accent = Color3.fromRGB(255, 215, 0),
        Text = Color3.fromRGB(255, 250, 240),
        SubText = Color3.fromRGB(200, 190, 170),
        Border = Color3.fromRGB(100, 90, 50),
        Hover = Color3.fromRGB(30, 30, 40)
    }
}

-- Utility Functions
local function CreateTween(instance, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragHandle = dragHandle or frame
    
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            CreateTween(frame, {
                Position = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
            }, 0.1)
        end
    end)
end

-- Main Library Functions
function Library:CreateWindow(config)
    config = config or {}
    local WindowName = config.Name or "UI Library"
    local ThemeName = config.Theme or "Dark"
    local Theme = Themes[ThemeName] or Themes.Dark
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUILibrary"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    -- Parent to CoreGui for executor compatibility
    pcall(function()
        ScreenGui.Parent = CoreGui
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main Window Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 550, 0, 400)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame
    
    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1.5
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = MainFrame
    
    -- Header Frame
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 50)
    Header.BackgroundColor3 = Theme.Secondary
    Header.BorderSizePixel = 0
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = WindowName
    Title.TextColor3 = Theme.Text
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
    MinimizeBtn.Position = UDim2.new(1, -45, 0.5, 0)
    MinimizeBtn.AnchorPoint = Vector2.new(0, 0.5)
    MinimizeBtn.BackgroundColor3 = Theme.Hover
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Text = "—"
    MinimizeBtn.TextColor3 = Theme.Text
    MinimizeBtn.TextSize = 16
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = Header
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 6)
    MinimizeCorner.Parent = MinimizeBtn
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 130, 1, -60)
    TabContainer.Position = UDim2.new(0, 10, 0, 55)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabContainer
    
    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 8)
    TabPadding.PaddingLeft = UDim.new(0, 8)
    TabPadding.PaddingRight = UDim.new(0, 8)
    TabPadding.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -155, 1, -60)
    ContentContainer.Position = UDim2.new(0, 145, 0, 55)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame
    
    MakeDraggable(MainFrame, Header)
    
    -- Minimize functionality
    local minimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            CreateTween(MainFrame, {Size = UDim2.new(0, 550, 0, 50)})
            MinimizeBtn.Text = "□"
        else
            CreateTween(MainFrame, {Size = UDim2.new(0, 550, 0, 400)})
            MinimizeBtn.Text = "—"
        end
    end)
    
    MinimizeBtn.MouseEnter:Connect(function()
        CreateTween(MinimizeBtn, {BackgroundColor3 = Theme.Accent}, 0.2)
    end)
    
    MinimizeBtn.MouseLeave:Connect(function()
        CreateTween(MinimizeBtn, {BackgroundColor3 = Theme.Hover}, 0.2)
    end)
    
    -- Initial animation
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    CreateTween(MainFrame, {Size = UDim2.new(0, 550, 0, 400)}, 0.5)
    
    local Window = {
        Theme = Theme,
        MainFrame = MainFrame,
        TabContainer = TabContainer,
        ContentContainer = ContentContainer,
        CurrentTab = nil,
        Tabs = {},
        ScreenGui = ScreenGui
    }
    
    -- Notification System
    function Window:Notify(config)
        config = config or {}
        local Title = config.Title or "Notification"
        local Message = config.Message or ""
        local Duration = config.Duration or 3
        local Type = config.Type or "Info"
        
        local NotificationContainer = ScreenGui:FindFirstChild("NotificationContainer")
        if not NotificationContainer then
            NotificationContainer = Instance.new("Frame")
            NotificationContainer.Name = "NotificationContainer"
            NotificationContainer.Size = UDim2.new(0, 300, 1, -20)
            NotificationContainer.Position = UDim2.new(1, -310, 0, 10)
            NotificationContainer.BackgroundTransparency = 1
            NotificationContainer.Parent = ScreenGui
            
            local NotifList = Instance.new("UIListLayout")
            NotifList.SortOrder = Enum.SortOrder.LayoutOrder
            NotifList.Padding = UDim.new(0, 8)
            NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
            NotifList.Parent = NotificationContainer
        end
        
        local TypeColors = {
            Info = Theme.Accent,
            Success = Color3.fromRGB(80, 200, 120),
            Warning = Color3.fromRGB(255, 180, 60),
            Error = Color3.fromRGB(220, 50, 70)
        }
        
        local AccentColor = TypeColors[Type] or Theme.Accent
        
        local Notification = Instance.new("Frame")
        Notification.Size = UDim2.new(1, 0, 0, 0)
        Notification.BackgroundColor3 = Theme.Secondary
        Notification.BorderSizePixel = 0
        Notification.ClipsDescendants = true
        Notification.Parent = NotificationContainer
        
        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 6)
        NotifCorner.Parent = Notification
        
        local NotifStroke = Instance.new("UIStroke")
        NotifStroke.Color = AccentColor
        NotifStroke.Thickness = 2
        NotifStroke.Parent = Notification
        
        local AccentBar = Instance.new("Frame")
        AccentBar.Size = UDim2.new(0, 4, 1, 0)
        AccentBar.BackgroundColor3 = AccentColor
        AccentBar.BorderSizePixel = 0
        AccentBar.Parent = Notification
        
        local BarCorner = Instance.new("UICorner")
        BarCorner.CornerRadius = UDim.new(0, 6)
        BarCorner.Parent = AccentBar
        
        local NotifTitle = Instance.new("TextLabel")
        NotifTitle.Size = UDim2.new(1, -20, 0, 20)
        NotifTitle.Position = UDim2.new(0, 12, 0, 8)
        NotifTitle.BackgroundTransparency = 1
        NotifTitle.Text = Title
        NotifTitle.TextColor3 = Theme.Text
        NotifTitle.TextSize = 14
        NotifTitle.Font = Enum.Font.GothamBold
        NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
        NotifTitle.Parent = Notification
        
        local NotifMessage = Instance.new("TextLabel")
        NotifMessage.Size = UDim2.new(1, -20, 0, 30)
        NotifMessage.Position = UDim2.new(0, 12, 0, 28)
        NotifMessage.BackgroundTransparency = 1
        NotifMessage.Text = Message
        NotifMessage.TextColor3 = Theme.SubText
        NotifMessage.TextSize = 12
        NotifMessage.Font = Enum.Font.Gotham
        NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
        NotifMessage.TextYAlignment = Enum.TextYAlignment.Top
        NotifMessage.TextWrapped = true
        NotifMessage.Parent = Notification
        
        CreateTween(Notification, {Size = UDim2.new(1, 0, 0, 70)}, 0.3)
        
        task.delay(Duration, function()
            CreateTween(Notification, {Size = UDim2.new(1, 0, 0, 0)}, 0.3)
            task.wait(0.3)
            Notification:Destroy()
        end)
    end
    
    function Window:CreateTab(name)
        name = name or "Tab"
        
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = name
        TabBtn.Size = UDim2.new(1, -8, 0, 35)
        TabBtn.BackgroundColor3 = Theme.Hover
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = name
        TabBtn.TextColor3 = Theme.Text
        TabBtn.TextSize = 14
        TabBtn.Font = Enum.Font.Gotham
        TabBtn.Parent = TabContainer
        
        local TabBtnCorner = Instance.new("UICorner")
        TabBtnCorner.CornerRadius = UDim.new(0, 6)
        TabBtnCorner.Parent = TabBtn
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList.Padding = UDim.new(0, 8)
        ContentList.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 8)
        ContentPadding.PaddingLeft = UDim.new(0, 8)
        ContentPadding.PaddingRight = UDim.new(0, 8)
        ContentPadding.PaddingBottom = UDim.new(0, 8)
        ContentPadding.Parent = TabContent
        
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 16)
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                CreateTween(tab.Button, {BackgroundColor3 = Theme.Hover}, 0.2)
            end
            
            TabContent.Visible = true
            CreateTween(TabBtn, {BackgroundColor3 = Theme.Accent}, 0.2)
            Window.CurrentTab = name
        end)
        
        TabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= name then
                CreateTween(TabBtn, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= name then
                CreateTween(TabBtn, {BackgroundColor3 = Theme.Hover}, 0.2)
            end
        end)
        
        if not Window.CurrentTab then
            TabContent.Visible = true
            TabBtn.BackgroundColor3 = Theme.Accent
            Window.CurrentTab = name
        end
        
        local Tab = {
            Button = TabBtn,
            Content = TabContent,
            Theme = Theme
        }
        
        Window.Tabs[name] = Tab
        
        function Tab:CreateButton(config)
            config = config or {}
            local ButtonName = config.Name or "Button"
            local Callback = config.Callback or function() end
            
            local ButtonFrame = Instance.new("Frame")
            ButtonFrame.Name = "ButtonFrame"
            ButtonFrame.Size = UDim2.new(1, -8, 0, 40)
            ButtonFrame.BackgroundColor3 = Theme.Secondary
            ButtonFrame.BorderSizePixel = 0
            ButtonFrame.Parent = TabContent
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = ButtonFrame
            
            local ButtonStroke = Instance.new("UIStroke")
            ButtonStroke.Color = Theme.Border
            ButtonStroke.Thickness = 1
            ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            ButtonStroke.Parent = ButtonFrame
            
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.BackgroundTransparency = 1
            Button.Text = ButtonName
            Button.TextColor3 = Theme.Text
            Button.TextSize = 14
            Button.Font = Enum.Font.Gotham
            Button.Parent = ButtonFrame
            
            Button.MouseButton1Click:Connect(function()
                CreateTween(ButtonFrame, {BackgroundColor3 = Theme.Accent}, 0.1)
                wait(0.1)
                CreateTween(ButtonFrame, {BackgroundColor3 = Theme.Secondary}, 0.2)
                pcall(Callback)
            end)
            
            Button.MouseEnter:Connect(function()
                CreateTween(ButtonFrame, {BackgroundColor3 = Theme.Hover}, 0.2)
            end)
            
            Button.MouseLeave:Connect(function()
                CreateTween(ButtonFrame, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end)
            
            return Button
        end
        
        function Tab:CreateToggle(config)
            config = config or {}
            local ToggleName = config.Name or "Toggle"
            local Default = config.Default or false
            local Callback = config.Callback or function() end
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Size = UDim2.new(1, -8, 0, 40)
            ToggleFrame.BackgroundColor3 = Theme.Secondary
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Color = Theme.Border
            ToggleStroke.Thickness = 1
            ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            ToggleStroke.Parent = ToggleFrame
            
            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Name = "Label"
            ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
            ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Text = ToggleName
            ToggleLabel.TextColor3 = Theme.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.Font = Enum.Font.Gotham
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            ToggleLabel.Parent = ToggleFrame
            
            local ToggleSwitch = Instance.new("Frame")
            ToggleSwitch.Name = "Switch"
            ToggleSwitch.Size = UDim2.new(0, 44, 0, 24)
            ToggleSwitch.Position = UDim2.new(1, -52, 0.5, 0)
            ToggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
            ToggleSwitch.BackgroundColor3 = Theme.Hover
            ToggleSwitch.BorderSizePixel = 0
            ToggleSwitch.Parent = ToggleFrame
            
            local SwitchCorner = Instance.new("UICorner")
            SwitchCorner.CornerRadius = UDim.new(1, 0)
            SwitchCorner.Parent = ToggleSwitch
            
            local SwitchCircle = Instance.new("Frame")
            SwitchCircle.Name = "Circle"
            SwitchCircle.Size = UDim2.new(0, 18, 0, 18)
            SwitchCircle.Position = UDim2.new(0, 3, 0.5, 0)
            SwitchCircle.AnchorPoint = Vector2.new(0, 0.5)
            SwitchCircle.BackgroundColor3 = Theme.Text
            SwitchCircle.BorderSizePixel = 0
            SwitchCircle.Parent = ToggleSwitch
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = SwitchCircle
            
            local toggled = Default
            
            local function UpdateToggle()
                if toggled then
                    CreateTween(ToggleSwitch, {BackgroundColor3 = Theme.Accent}, 0.2)
                    CreateTween(SwitchCircle, {Position = UDim2.new(1, -21, 0.5, 0)}, 0.2)
                else
                    CreateTween(ToggleSwitch, {BackgroundColor3 = Theme.Hover}, 0.2)
                    CreateTween(SwitchCircle, {Position = UDim2.new(0, 3, 0.5, 0)}, 0.2)
                end
                pcall(Callback, toggled)
            end
            
            UpdateToggle()
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Name = "ToggleBtn"
            ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
            ToggleBtn.BackgroundTransparency = 1
            ToggleBtn.Text = ""
            ToggleBtn.Parent = ToggleFrame
            
            ToggleBtn.MouseButton1Click:Connect(function()
                toggled = not toggled
                UpdateToggle()
            end)
            
            return {
                SetValue = function(self, value)
                    toggled = value
                    UpdateToggle()
                end
            }
        end
        
        function Tab:CreateSlider(config)
            config = config or {}
            local SliderName = config.Name or "Slider"
            local Range = config.Range or {0, 100}
            local Default = config.Default or Range[1]
            local Callback = config.Callback or function() end
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = "SliderFrame"
            SliderFrame.Size = UDim2.new(1, -8, 0, 55)
            SliderFrame.BackgroundColor3 = Theme.Secondary
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = SliderFrame
            
            local SliderStroke = Instance.new("UIStroke")
            SliderStroke.Color = Theme.Border
            SliderStroke.Thickness = 1
            SliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            SliderStroke.Parent = SliderFrame
            
            local SliderLabel = Instance.new("TextLabel")
            SliderLabel.Name = "Label"
            SliderLabel.Size = UDim2.new(1, -70, 0, 20)
            SliderLabel.Position = UDim2.new(0, 12, 0, 8)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = SliderName
            SliderLabel.TextColor3 = Theme.Text
            SliderLabel.TextSize = 14
            SliderLabel.Font = Enum.Font.Gotham
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            SliderLabel.Parent = SliderFrame
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Name = "ValueLabel"
            ValueLabel.Size = UDim2.new(0, 60, 0, 20)
            ValueLabel.Position = UDim2.new(1, -65, 0, 8)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(Default)
            ValueLabel.TextColor3 = Theme.Accent
            ValueLabel.TextSize = 14
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValueLabel.Parent = SliderFrame
            
            local SliderBar = Instance.new("Frame")
            SliderBar.Name = "SliderBar"
            SliderBar.Size = UDim2.new(1, -24, 0, 6)
            SliderBar.Position = UDim2.new(0, 12, 1, -18)
            SliderBar.BackgroundColor3 = Theme.Hover
            SliderBar.BorderSizePixel = 0
            SliderBar.Parent = SliderFrame
            
            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = SliderBar
            
            local SliderFill = Instance.new("Frame")
            SliderFill.Name = "Fill"
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            SliderFill.BackgroundColor3 = Theme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBar
            
            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = SliderFill
            
            local SliderButton = Instance.new("TextButton")
            SliderButton.Name = "SliderButton"
            SliderButton.Size = UDim2.new(1, 0, 0, 30)
            SliderButton.Position = UDim2.new(0, 0, 1, -30)
            SliderButton.BackgroundTransparency = 1
            SliderButton.Text = ""
            SliderButton.Parent = SliderFrame
            
            local currentValue = Default
            local dragging = false
            
            local function UpdateSlider(input)
                local barSize = SliderBar.AbsoluteSize.X
                local mouseX = input.Position.X
                local barX = SliderBar.AbsolutePosition.X
                
                local percent = math.clamp((mouseX - barX) / barSize, 0, 1)
                currentValue = math.floor(Range[1] + (Range[2] - Range[1]) * percent)
                
                ValueLabel.Text = tostring(currentValue)
                CreateTween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
                
                pcall(Callback, currentValue)
            end
            
            SliderButton.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    UpdateSlider(input)
                end
            end)
            
            SliderButton.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(input)
                end
            end)
            
            local initPercent = (Default - Range[1]) / (Range[2] - Range[1])
            SliderFill.Size = UDim2.new(initPercent, 0, 1, 0)
            
            return {
                SetValue = function(self, value)
                    currentValue = math.clamp(value, Range[1], Range[2])
                    ValueLabel.Text = tostring(currentValue)
                    local percent = (currentValue - Range[1]) / (Range[2] - Range[1])
                    CreateTween(SliderFill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.2)
                    pcall(Callback, currentValue)
                end
            }
        end
        
        function Tab:CreateTextInput(config)
            config = config or {}
            local InputName = config.Name or "Input"
            local PlaceholderText = config.PlaceholderText or "Enter text..."
            local Callback = config.Callback or function() end
            
            local InputFrame = Instance.new("Frame")
            InputFrame.Name = "InputFrame"
            InputFrame.Size = UDim2.new(1, -8, 0, 55)
            InputFrame.BackgroundColor3 = Theme.Secondary
            InputFrame.BorderSizePixel = 0
            InputFrame.Parent = TabContent
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 6)
            InputCorner.Parent = InputFrame
            
            local InputStroke = Instance.new("UIStroke")
            InputStroke.Color = Theme.Border
            InputStroke.Thickness = 1
            InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            InputStroke.Parent = InputFrame
            
            local InputLabel = Instance.new("TextLabel")
            InputLabel.Name = "Label"
            InputLabel.Size = UDim2.new(1, -24, 0, 20)
            InputLabel.Position = UDim2.new(0, 12, 0, 6)
            InputLabel.BackgroundTransparency = 1
            InputLabel.Text = InputName
            InputLabel.TextColor3 = Theme.Text
            InputLabel.TextSize = 14
            InputLabel.Font = Enum.Font.Gotham
            InputLabel.TextXAlignment = Enum.TextXAlignment.Left
            InputLabel.Parent = InputFrame
            
            local TextBox = Instance.new("TextBox")
            TextBox.Name = "TextBox"
            TextBox.Size = UDim2.new(1, -24, 0, 28)
            TextBox.Position = UDim2.new(0, 12, 1, -32)
            TextBox.BackgroundColor3 = Theme.Hover
            TextBox.BorderSizePixel = 0
            TextBox.Text = ""
            TextBox.PlaceholderText = PlaceholderText
            TextBox.TextColor3 = Theme.Text
            TextBox.PlaceholderColor3 = Theme.SubText
            TextBox.TextSize = 13
            TextBox.Font = Enum.Font.Gotham
            TextBox.TextXAlignment = Enum.TextXAlignment.Left
            TextBox.ClearTextOnFocus = false
            TextBox.Parent = InputFrame
            
            local TextBoxCorner = Instance.new("UICorner")
            TextBoxCorner.CornerRadius = UDim.new(0, 4)
            TextBoxCorner.Parent = TextBox
            
            local TextBoxPadding = Instance.new("UIPadding")
            TextBoxPadding.PaddingLeft = UDim.new(0, 8)
            TextBoxPadding.PaddingRight = UDim.new(0, 8)
            TextBoxPadding.Parent = TextBox
            
            TextBox.Focused:Connect(function()
                CreateTween(InputStroke, {Color = Theme.Accent}, 0.2)
                CreateTween(TextBox, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end)
            
            TextBox.FocusLost:Connect(function(enterPressed)
                CreateTween(InputStroke, {Color = Theme.Border}, 0.2)
                CreateTween(TextBox, {BackgroundColor3 = Theme.Hover}, 0.2)
                
                if enterPressed then
                    pcall(Callback, TextBox.Text)
                end
            end)
            
            return {
                GetText = function(self)
                    return TextBox.Text
                end,
                SetText = function(self, text)
                    TextBox.Text = text
                end
            }
        end
        
        function Tab:CreateLabel(config)
            config = config or {}
            local LabelText = config.Text or "Label"
            
            local LabelFrame = Instance.new("Frame")
            LabelFrame.Name = "LabelFrame"
            LabelFrame.Size = UDim2.new(1, -8, 0, 35)
            LabelFrame.BackgroundColor3 = Theme.Secondary
            LabelFrame.BorderSizePixel = 0
            LabelFrame.Parent = TabContent
            
            local LabelCorner = Instance.new("UICorner")
            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Parent = LabelFrame
            
            local LabelStroke = Instance.new("UIStroke")
            LabelStroke.Color = Theme.Border
            LabelStroke.Thickness = 1
            LabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            LabelStroke.Parent = LabelFrame
            
            local Label = Instance.new("TextLabel")
            Label.Name = "Label"
            Label.Size = UDim2.new(1, -24, 1, 0)
            Label.Position = UDim2.new(0, 12, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = LabelText
            Label.TextColor3 = Theme.SubText
            Label.TextSize = 13
            Label.Font = Enum.Font.Gotham
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextWrapped = true
            Label.Parent = LabelFrame
            
            return {
                SetText = function(self, text)
                    Label.Text = text
                end
            }
        end
        
        function Tab:CreateDropdown(config)
            config = config or {}
            local DropdownName = config.Name or "Dropdown"
            local Options = config.Options or {"Option 1", "Option 2", "Option 3"}
            local Default = config.Default or Options[1]
            local Callback = config.Callback or function() end
            
            local DropdownFrame = Instance.new("Frame")
            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Size = UDim2.new(1, -8, 0, 40)
            DropdownFrame.BackgroundColor3 = Theme.Secondary
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent
            DropdownFrame.ClipsDescendants = false
            DropdownFrame.ZIndex = 10
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 6)
            DropdownCorner.Parent = DropdownFrame
            
            local DropdownStroke = Instance.new("UIStroke")
            DropdownStroke.Color = Theme.Border
            DropdownStroke.Thickness = 1
            DropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            DropdownStroke.Parent = DropdownFrame
            
            local DropdownLabel = Instance.new("TextLabel")
            DropdownLabel.Name = "Label"
            DropdownLabel.Size = UDim2.new(1, -80, 1, 0)
            DropdownLabel.Position = UDim2.new(0, 12, 0, 0)
            DropdownLabel.BackgroundTransparency = 1
            DropdownLabel.Text = DropdownName
            DropdownLabel.TextColor3 = Theme.Text
            DropdownLabel.TextSize = 14
            DropdownLabel.Font = Enum.Font.Gotham
            DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            DropdownLabel.Parent = DropdownFrame
            
            local SelectedFrame = Instance.new("Frame")
            SelectedFrame.Name = "Selected"
            SelectedFrame.Size = UDim2.new(0, 120, 0, 28)
            SelectedFrame.Position = UDim2.new(1, -128, 0.5, 0)
            SelectedFrame.AnchorPoint = Vector2.new(0, 0.5)
            SelectedFrame.BackgroundColor3 = Theme.Hover
            SelectedFrame.BorderSizePixel = 0
            SelectedFrame.Parent = DropdownFrame
            
            local SelectedCorner = Instance.new("UICorner")
            SelectedCorner.CornerRadius = UDim.new(0, 4)
            SelectedCorner.Parent = SelectedFrame
            
            local SelectedText = Instance.new("TextLabel")
            SelectedText.Size = UDim2.new(1, -30, 1, 0)
            SelectedText.Position = UDim2.new(0, 8, 0, 0)
            SelectedText.BackgroundTransparency = 1
            SelectedText.Text = Default
            SelectedText.TextColor3 = Theme.Text
            SelectedText.TextSize = 13
            SelectedText.Font = Enum.Font.Gotham
            SelectedText.TextXAlignment = Enum.TextXAlignment.Left
            SelectedText.TextTruncate = Enum.TextTruncate.AtEnd
            SelectedText.Parent = SelectedFrame
            
            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 20, 1, 0)
            Arrow.Position = UDim2.new(1, -22, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Theme.SubText
            Arrow.TextSize = 10
            Arrow.Font = Enum.Font.Gotham
            Arrow.Parent = SelectedFrame
            
            local OptionsContainer = Instance.new("Frame")
            OptionsContainer.Name = "Options"
            OptionsContainer.Size = UDim2.new(0, 120, 0, 0)
            OptionsContainer.Position = UDim2.new(1, -128, 1, 5)
            OptionsContainer.BackgroundColor3 = Theme.Secondary
            OptionsContainer.BorderSizePixel = 0
            OptionsContainer.Visible = false
            OptionsContainer.ZIndex = 100
            OptionsContainer.Parent = DropdownFrame
            
            local OptionsCorner = Instance.new("UICorner")
            OptionsCorner.CornerRadius = UDim.new(0, 6)
            OptionsCorner.Parent = OptionsContainer
            
            local OptionsStroke = Instance.new("UIStroke")
            OptionsStroke.Color = Theme.Border
            OptionsStroke.Thickness = 1
            OptionsStroke.Parent = OptionsContainer
            
            local OptionsList = Instance.new("UIListLayout")
            OptionsList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsList.Padding = UDim.new(0, 2)
            OptionsList.Parent = OptionsContainer
            
            local OptionsPadding = Instance.new("UIPadding")
            OptionsPadding.PaddingTop = UDim.new(0, 4)
            OptionsPadding.PaddingBottom = UDim.new(0, 4)
            OptionsPadding.PaddingLeft = UDim.new(0, 4)
            OptionsPadding.PaddingRight = UDim.new(0, 4)
            OptionsPadding.Parent = OptionsContainer
            
            local isOpen = false
            local currentValue = Default
            
            local function CreateOptionButtons()
                for _, child in ipairs(OptionsContainer:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                for _, option in ipairs(Options) do
                    local OptionButton = Instance.new("TextButton")
                    OptionButton.Size = UDim2.new(1, -8, 0, 28)
                    OptionButton.BackgroundColor3 = Theme.Hover
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Text = option
                    OptionButton.TextColor3 = Theme.Text
                    OptionButton.TextSize = 12
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.ZIndex = 101
                    OptionButton.Parent = OptionsContainer
                    
                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionButton
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        currentValue = option
                        SelectedText.Text = option
                        isOpen = false
                        CreateTween(OptionsContainer, {Size = UDim2.new(0, 120, 0, 0)}, 0.2)
                        CreateTween(Arrow, {Rotation = 0}, 0.2)
                        task.wait(0.2)
                        OptionsContainer.Visible = false
                        pcall(Callback, option)
                    end)
                    
                    OptionButton.MouseEnter:Connect(function()
                        CreateTween(OptionButton, {BackgroundColor3 = Theme.Accent}, 0.15)
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        CreateTween(OptionButton, {BackgroundColor3 = Theme.Hover}, 0.15)
                    end)
                end
            end
            
            CreateOptionButtons()
            
            local DropdownButton = Instance.new("TextButton")
            DropdownButton.Size = UDim2.new(1, 0, 1, 0)
            DropdownButton.BackgroundTransparency = 1
            DropdownButton.Text = ""
            DropdownButton.ZIndex = 11
            DropdownButton.Parent = DropdownFrame
            
            DropdownButton.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                
                if isOpen then
                    local optionCount = #Options
                    local containerHeight = math.min(optionCount * 30 + 8, 200)
                    OptionsContainer.Visible = true
                    CreateTween(OptionsContainer, {Size = UDim2.new(0, 120, 0, containerHeight)}, 0.2)
                    CreateTween(Arrow, {Rotation = 180}, 0.2)
                else
                    CreateTween(OptionsContainer, {Size = UDim2.new(0, 120, 0, 0)}, 0.2)
                    CreateTween(Arrow, {Rotation = 0}, 0.2)
                    task.wait(0.2)
                    OptionsContainer.Visible = false
                end
            end)
            
            DropdownButton.MouseEnter:Connect(function()
                CreateTween(SelectedFrame, {BackgroundColor3 = Theme.Secondary}, 0.2)
            end)
            
            DropdownButton.MouseLeave:Connect(function()
                CreateTween(SelectedFrame, {BackgroundColor3 = Theme.Hover}, 0.2)
            end)
            
            return {
                SetValue = function(self, value)
                    if table.find(Options, value) then
                        currentValue = value
                        SelectedText.Text = value
                        pcall(Callback, value)
                    end
                end,
                GetValue = function(self)
                    return currentValue
                end,
                Refresh = function(self, newOptions)
                    Options = newOptions
                    CreateOptionButtons()
                end
            }
        end
        
        return Tab
    end
    
    return Window
end

return Library
