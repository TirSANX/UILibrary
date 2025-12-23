repeat wait() until game:IsLoaded()
-- Use loadstring to avoid "nil value" errors with sharedRequire
--[=[
    Optimized UI Library (Fixed)
    - Fixed UI resizing visual bugs (Green Button)
    - Added ClipsDescendants to containers
    - Switched to Scale-based sizing for smooth animations
    - Removed redundant updateChildSizes logic
]=]
local Theme = {
    Colors = {
        -- New Theme
        MainBack = Color3.fromRGB(30, 30, 35),       -- Sidebar Color
        ContentBack = Color3.fromRGB(25, 25, 30),    -- Main Background
        SectionBack = Color3.fromRGB(35, 35, 40),    -- Collapsible Section Background
        ElementBack = Color3.fromRGB(45, 45, 50),    -- Buttons, Inputs etc.
        Text = Color3.fromRGB(220, 220, 220),        -- Main Text
        Primary = Color3.fromRGB(60, 60, 75),        -- Accent Color
        Hover = Color3.fromRGB(55, 55, 60),          -- Hover Color
        Border = Color3.fromRGB(60, 60, 65),         -- Border Color
        PrimaryLight = Color3.fromRGB(80, 80, 95),   -- Lighter Accent

        -- Aliases & Specifics
        TextDark = Color3.fromRGB(220, 220, 220),    -- Alias for new Text
        TextLight = Color3.fromRGB(220, 220, 220),   -- Alias for new Text
        Close = Color3.fromRGB(255, 95, 87),
        Minimize = Color3.fromRGB(255, 189, 46),
        Resize = Color3.fromRGB(40, 200, 64),
        Success = Color3.fromRGB(39, 200, 63),
        SplashBack = Color3.fromRGB(25, 25, 25),
        Shadow = Color3.fromRGB(0, 0, 0),
        Gray = Color3.fromRGB(45, 45, 50),           -- Kept for compatibility
        LightGray = Color3.fromRGB(45, 45, 50)      -- Kept for compatibility
    },
    Fonts = {
        Title = Enum.Font.GothamMedium,
        Body = Enum.Font.Gotham
    },
    Sizes = {
        LargeRadius = UDim.new(0, 8),
        SmallRadius = UDim.new(0, 6),
        FullRadius = UDim.new(1, 0),
        SwitchRadius = UDim.new(0, 4)
    }
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local lib = {}
local sections = {}
local workareas = {}
local sectionAPIs = {}
local notifs = {}
local visible = true
local dbcooper = false

local function tp(ins, pos, time)
    TweenService:Create(ins, TweenInfo.new(time, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = pos}):Play()
end

local function createGradient(parent, color1, color2)
    local grad = Instance.new("UIGradient", parent)
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    grad.Rotation = 90
    return grad
end

function lib:init(ti, sub_ti, dosplash, visiblekey, deleteprevious)
    local scrgui
    local sidebar
    local search
    local logo
    local window = {}
    local notifdarkness, notif2darkness
    local activeWorkarea = nil

    local isMobile = UserInputService.TouchEnabled
    local minSize = isMobile and Vector2.new(650, 400) or Vector2.new(850, 600)
    local defaultSize = isMobile and Vector2.new(650, 400) or Vector2.new(850, 600)
    
    local isMaximized = false
    local originalSize
    local originalPosition

    if syn then
        if CoreGui:FindFirstChild("AegisLib") and deleteprevious then
            if CoreGui.AegisLib:FindFirstChild("main") then
                tp(CoreGui.AegisLib.main, CoreGui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            end
            Debris:AddItem(CoreGui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        
        syn.protect_gui(scrgui)
        scrgui.Parent = CoreGui
    elseif gethui then
        local hui = gethui()
        if hui:FindFirstChild("AegisLib") and deleteprevious then
            if hui.AegisLib:FindFirstChild("main") then
                hui.AegisLib.main:TweenPosition(hui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), "InOut", "Quart", 0.5)
            end
            Debris:AddItem(hui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        scrgui.Parent = hui
    else
        if CoreGui:FindFirstChild("AegisLib") and deleteprevious then
            if CoreGui.AegisLib:FindFirstChild("main") then
                tp(CoreGui.AegisLib.main, CoreGui.AegisLib.main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            end
            Debris:AddItem(CoreGui.AegisLib, 1)
        end
        scrgui = Instance.new("ScreenGui")
        scrgui.Name = "AegisLib"
        scrgui.Parent = CoreGui
    end

    local loadingScreen
    local progressBar
    local function updateLoadingProgress(statusText, progress)
        if loadingScreen and loadingScreen:FindFirstChild("Status") then
            loadingScreen.Status.Text = statusText
        end
        if progressBar then
            local tween = TweenService:Create(progressBar, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(progress, 0, 1, 0)})
            tween:Play()
        end
    end

    if dosplash then
        local blur = Instance.new("BlurEffect")
        blur.Name = "MacOsLibBlur"
        blur.Parent = game:GetService("Lighting")
        blur.Size = 0
        blur.Enabled = true
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 16}):Play()

        local statusLabel

        loadingScreen = Instance.new("Frame")
        loadingScreen.Name = "LoadingScreen"
        loadingScreen.Parent = scrgui
        loadingScreen.AnchorPoint = Vector2.new(0.5, 0.5) 
        loadingScreen.BackgroundColor3 = Theme.Colors.SplashBack
        loadingScreen.BackgroundTransparency = 1
        loadingScreen.Position = UDim2.new(0.5, 0, 0.5, 0) 
        loadingScreen.Size = UDim2.new(0, 400, 0, 250)
        loadingScreen.ZIndex = 1000
        
        local corner = Instance.new("UICorner", loadingScreen)
        corner.CornerRadius = Theme.Sizes.SmallRadius

        local logo = Instance.new("ImageLabel", loadingScreen)
        logo.Size = UDim2.new(0, 400, 0, 350)
        logo.Position = UDim2.new(0.5, 0, 0.4, 0)
        logo.AnchorPoint = Vector2.new(0.5, 0.5)
        logo.BackgroundTransparency = 1
        logo.Image = "rbxassetid://101129417614969"
        logo.ZIndex = 1001
        logo.ScaleType = Enum.ScaleType.Fit

        statusLabel = Instance.new("TextLabel", loadingScreen)
        statusLabel.Name = "Status"
        statusLabel.Size = UDim2.new(1, -20, 0, 30)
        statusLabel.Position = UDim2.new(0.5, 0, 0.8, 0)
        statusLabel.AnchorPoint = Vector2.new(0.5, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Font = Enum.Font.SourceSans
        statusLabel.Text = "Initializing..."
        statusLabel.TextColor3 = Theme.Colors.TextLight
        statusLabel.TextSize = 16
        statusLabel.ZIndex = 1001

        local progressBarTrack = Instance.new("Frame", loadingScreen)
        progressBarTrack.Size = UDim2.new(0.8, 0, 0, 8)
        progressBarTrack.Position = UDim2.new(0.5, 0, 0.95, 0)
        progressBarTrack.AnchorPoint = Vector2.new(0.5, 1)
        progressBarTrack.BackgroundColor3 = Theme.Colors.Gray
        progressBarTrack.ZIndex = 1001

        local uc_progress_track = Instance.new("UICorner", progressBarTrack)
        uc_progress_track.CornerRadius = Theme.Sizes.FullRadius

        progressBar = Instance.new("Frame", progressBarTrack)
        progressBar.Size = UDim2.new(0, 0, 1, 0)
        progressBar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
        progressBar.ZIndex = 1002
        
        createGradient(progressBar, Color3.fromRGB(139, 92, 246), Color3.fromRGB(160, 120, 255))

        local uc_progress_bar = Instance.new("UICorner", progressBar)
        uc_progress_bar.CornerRadius = Theme.Sizes.FullRadius

        loadingScreen.Position = UDim2.new(0.5, 0, -0.5, 0)
        tp(loadingScreen, UDim2.new(0.5, 0, 0.5, 0), 0.5)
        task.wait(0.5)
    end

    updateLoadingProgress("Creating main window...", 0.25)
    task.wait(1)

    local main = Instance.new("Frame")
    main.Name = "main"
    main.Parent = scrgui
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Theme.Colors.MainBack
    main.BackgroundTransparency = 0.01
    main.Position = UDim2.new(0.5, 0, 2, 0)
    main.Size = UDim2.new(0, defaultSize.X, 0, defaultSize.Y)
    main.ClipsDescendants = true
    main.Active = true 

    local uc = Instance.new("UICorner")
    uc.CornerRadius = Theme.Sizes.LargeRadius
    uc.Parent = main

    local mainShadow = Instance.new("ImageLabel")
    mainShadow.Name = "mainShadow"
    mainShadow.Parent = scrgui
    mainShadow.AnchorPoint = main.AnchorPoint
    mainShadow.BackgroundTransparency = 1
    mainShadow.Position = main.Position
    mainShadow.Size = main.Size
    mainShadow.ZIndex = main.ZIndex - 1
    mainShadow.Image = "rbxassetid://313486536"
    mainShadow.ImageColor3 = Theme.Colors.Shadow
    mainShadow.ImageTransparency = 0.5
    mainShadow.ScaleType = Enum.ScaleType.Slice
    mainShadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local mainFloatingBorder = Instance.new("Frame")
    mainFloatingBorder.Name = "FloatingBorder"
    mainFloatingBorder.Parent = main
    mainFloatingBorder.BackgroundTransparency = 1
    mainFloatingBorder.Size = UDim2.new(1, 0, 1, 0)
    mainFloatingBorder.ZIndex = 198

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Parent = mainFloatingBorder
    mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    mainStroke.Color = Color3.fromRGB(200, 200, 200)
    mainStroke.Thickness = 1
    mainStroke.Transparency = 0.8

    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = Theme.Sizes.LargeRadius
    borderCorner.Parent = mainFloatingBorder

    local indicatorHeight = 50
    local collapsedWidth = 50
    local expandedWidth = 200
    local collapsedSize = UDim2.new(0, collapsedWidth, 0, indicatorHeight)
    local expandedSize = UDim2.new(0, expandedWidth, 0, indicatorHeight)
    local hiddenIndicator = Instance.new("TextButton")
    hiddenIndicator.AutoButtonColor = false
    hiddenIndicator.Name = "HiddenIndicator"
    hiddenIndicator.Parent = scrgui
    hiddenIndicator.AnchorPoint = Vector2.new(1, 0.5) 
    hiddenIndicator.Position = UDim2.new(1, expandedWidth, 0.5, 0)
    hiddenIndicator.Size = collapsedSize
    hiddenIndicator.BackgroundTransparency = 1
    hiddenIndicator.ZIndex = 8
    hiddenIndicator.Visible = false
    hiddenIndicator.Text = ""

    local hiBackground = Instance.new("Frame")
    hiBackground.Name = "BackgroundFrame"
    hiBackground.Parent = hiddenIndicator
    hiBackground.BackgroundTransparency = 1
    hiBackground.BorderSizePixel = 0
    hiBackground.Size = UDim2.new(1, 0, 1, 0)
    hiBackground.ZIndex = 1
    hiBackground.ClipsDescendants = true

    local hiLogo = Instance.new("ImageLabel", hiBackground)
    hiLogo.BackgroundTransparency = 1
    hiLogo.Size = UDim2.new(0, indicatorHeight, 0, indicatorHeight)
    hiLogo.Position = UDim2.new(0, 0, 0.5, 0)
    hiLogo.AnchorPoint = Vector2.new(0, 0.5)
    hiLogo.Image = "rbxassetid://101129417614969"
    hiLogo.ZIndex = 10 

    local hiText = Instance.new("TextLabel", hiBackground)
    hiText.BackgroundTransparency = 1
    hiText.Position = UDim2.new(0, indicatorHeight + 10, 0.5, 0)
    hiText.Size = UDim2.new(1, -(indicatorHeight + 20), 1, 0)
    hiText.AnchorPoint = Vector2.new(0, 0.5)
    hiText.Font = Theme.Fonts.Body
    hiText.TextColor3 = Theme.Colors.TextDark
    hiText.TextSize = 16
    hiText.ZIndex = 10
    hiText.Text = "Press " .. visiblekey.Name .. " to show" 
    hiText.TextXAlignment = Enum.TextXAlignment.Left
    hiText.TextYAlignment = Enum.TextYAlignment.Center 
    hiText.TextWrapped = true 
    hiText.Visible = false 
    
    hiddenIndicator.MouseEnter:Connect(function()
        if not visible then
            TweenService:Create(hiddenIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = expandedSize}):Play()
            hiText.Visible = true
        end
    end)

    hiddenIndicator.MouseLeave:Connect(function()
        if not visible then
            TweenService:Create(hiddenIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = collapsedSize}):Play()
            hiText.Visible = false
        end
    end)

    hiddenIndicator.MouseButton1Click:Connect(function()
        window:ToggleVisible()
    end)

    local mobileIndicator = Instance.new("TextButton")
    mobileIndicator.Name = "MobileIndicator"
    mobileIndicator.Parent = scrgui
    mobileIndicator.Size = UDim2.new(0, 45, 0, 45)
    mobileIndicator.Position = UDim2.new(0, 20, 0.5, 0)
    mobileIndicator.BackgroundColor3 = Theme.Colors.ContentBack
    mobileIndicator.BackgroundTransparency = 0
    mobileIndicator.ZIndex = 8
    mobileIndicator.Visible = false
    mobileIndicator.AutoButtonColor = false
    mobileIndicator.Text = ""
    mobileIndicator.Draggable = true
    mobileIndicator.Active = true

    local miCorner = Instance.new("UICorner", mobileIndicator)
    miCorner.CornerRadius = Theme.Sizes.SmallRadius

    local miStroke = Instance.new("UIStroke", mobileIndicator)
    miStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    miStroke.Color = Theme.Colors.Primary
    miStroke.Thickness = 1.5

    local miLogo = Instance.new("ImageLabel", mobileIndicator)
    miLogo.ZIndex = 9
    miLogo.BackgroundTransparency = 1
    miLogo.Size = UDim2.new(0, 45, 0, 45)
    miLogo.Position = UDim2.new(0.5, 0, 0.5, 0)
    miLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    miLogo.Image = "rbxassetid://101129417614969"

    mobileIndicator.MouseButton1Click:Connect(function()
        if not visible then
            window:ToggleVisible()
        end
    end)

    updateLoadingProgress("Setting up components...", 0.5)
    task.wait(1)
    
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    local sidebarWidth = 200
    
    local workarea = Instance.new("Frame")
    workarea.Name = "workarea"
    workarea.Parent = main
    workarea.BackgroundColor3 = Theme.Colors.ContentBack

    workarea.Position = UDim2.new(0, sidebarWidth, 0, 0)
    workarea.Size = UDim2.new(1, -sidebarWidth, 1, 0) 
    workarea.Active = false

    workarea.ClipsDescendants = true 
    
    local uc_2 = Instance.new("UICorner")
    uc_2.CornerRadius = Theme.Sizes.LargeRadius
    uc_2.Parent = workarea

    local workareacornerhider = Instance.new("Frame")
    workareacornerhider.Name = "workareacornerhider"
    workareacornerhider.Parent = workarea
    workareacornerhider.BackgroundColor3 = Theme.Colors.ContentBack
    workareacornerhider.BorderSizePixel = 0
    workareacornerhider.Size = UDim2.new(0, 18, 1, 0)

    logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Parent = main
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://131523188424149"
    logo.Size = UDim2.new(0, 150, 0, 100)
    logo.Position = UDim2.new(0, (sidebarWidth / 2) - 5, 0, 60)
    logo.AnchorPoint = Vector2.new(0.4, 0)
    logo.ZIndex = 2

    search = Instance.new("Frame")
    search.Name = "search"
    search.Parent = main
    search.BackgroundColor3 = Theme.Colors.LightGray
    search.BackgroundColor3 = Theme.Colors.ElementBack
    search.Position = UDim2.new(0, (sidebarWidth / 2), 0, 170)
    search.AnchorPoint = Vector2.new(0.5, 0)
    search.Size = UDim2.new(0, sidebarWidth - 30, 0, 34)

    local uc_8 = Instance.new("UICorner")
    uc_8.CornerRadius = Theme.Sizes.SmallRadius
    uc_8.Parent = search

    local searchicon = Instance.new("ImageButton")
    searchicon.Name = "searchicon"
    searchicon.Parent = search
    searchicon.BackgroundTransparency = 1
    searchicon.Position = UDim2.new(0, 10, 0.5, 0)
    searchicon.AnchorPoint = Vector2.new(0, 0.5)
    searchicon.Size = UDim2.new(0, 20, 0, 20)
    searchicon.Image = "rbxassetid://2804603863"
    searchicon.ImageColor3 = Theme.Colors.Text
    searchicon.ScaleType = Enum.ScaleType.Fit

    local searchtextbox = Instance.new("TextBox")
    searchtextbox.Name = "searchtextbox"
    searchtextbox.Parent = search
    searchtextbox.BackgroundTransparency = 1
    searchtextbox.ClipsDescendants = true
    searchtextbox.Position = UDim2.new(0, 38, 0.5, 0)
    searchtextbox.AnchorPoint = Vector2.new(0, 0.5)
    searchtextbox.Size = UDim2.new(1, -48, 1, 0)
    searchtextbox.Font = Theme.Fonts.Body
    searchtextbox.LineHeight = 0.870
    searchtextbox.PlaceholderText = "Search"
    searchtextbox.Text = ""
    searchtextbox.TextColor3 = Theme.Colors.Text
    searchtextbox.TextSize = 18
    searchtextbox.TextXAlignment = Enum.TextXAlignment.Left

    searchicon.MouseButton1Click:Connect(function()
        searchtextbox:CaptureFocus()
    end)

    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                update(input)
            end
        end
    end)

    updateLoadingProgress("Configuring sidebar...", 0.75)
    task.wait(0.6)

    sidebar = Instance.new("ScrollingFrame")
    sidebar.Name = "sidebar"
    sidebar.Parent = main
    sidebar.Active = true
    sidebar.BackgroundTransparency = 0
    sidebar.BackgroundColor3 = Theme.Colors.MainBack
    sidebar.BorderSizePixel = 0
    sidebar.Position = UDim2.new(0, 10, 0, 214)

    sidebar.Size = UDim2.new(0, sidebarWidth - 15, 1, -229) 
    sidebar.AutomaticCanvasSize = "Y"
    sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
    sidebar.ScrollBarThickness = 3
    sidebar.ScrollBarImageColor3 = Theme.Colors.Text

    local ull_2 = Instance.new("UIListLayout")
    ull_2.Parent = sidebar
    ull_2.SortOrder = Enum.SortOrder.LayoutOrder
    ull_2.Padding = UDim.new(0, 5)

    searchtextbox:GetPropertyChangedSignal("Text"):Connect(function()
        local inputText = string.upper(searchtextbox.Text)
        
        for _, child in pairs(sidebar:GetChildren()) do
            if child.Name == "sidebar2" or child.Name == "sidebardivider" then
                local title = child:FindFirstChild("SectionTitle")
                local subtitle = child:FindFirstChild("SectionSubtitle")
                
                local found = false
                if title and string.find(string.upper(title.Text), inputText) then
                    found = true
                end
                if subtitle and string.find(string.upper(subtitle.Text), inputText) then
                    found = true
                end
                if inputText == "" then
                    found = true
                end

                if child.Name == "sidebardivider" then
                    if string.find(string.upper(child.Text), inputText) or inputText == "" then
                        found = true
                    end
                end

                child.Visible = found
            end
        end
    end)
    
    local buttons = Instance.new("Frame")
    buttons.Name = "buttons"
    buttons.Parent = main
    buttons.BackgroundTransparency = 1
    buttons.Size = UDim2.new(0, 105, 0, 57)
    buttons.Position = UDim2.new(0, 0, 0, 0)
    buttons.ZIndex = 10

    local ull_3 = Instance.new("UIListLayout")
    ull_3.Parent = buttons
    ull_3.FillDirection = Enum.FillDirection.Horizontal
    ull_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ull_3.SortOrder = Enum.SortOrder.LayoutOrder
    ull_3.VerticalAlignment = Enum.VerticalAlignment.Center
    ull_3.Padding = UDim.new(0, 10)

    local close = Instance.new("TextButton")
    close.Name = "close"
    close.Parent = buttons
    close.BackgroundColor3 = Theme.Colors.Close
    close.Size = UDim2.new(0, 16, 0, 16)
    close.AutoButtonColor = false
    close.Text = ""
    close.MouseButton1Click:Connect(function()
        window:Notify2(
            "CONFIRM CLOSE!",
            "Are you sure you want to destroy the UI?",
            "CLOSE",
            "CANCEL",
            "rbxassetid://12608260095",
            function() scrgui:Destroy() end,
            function() end,
            Theme.Colors.Close
        )
    end)

    local uc_18 = Instance.new("UICorner")
    uc_18.CornerRadius = Theme.Sizes.FullRadius
    uc_18.Parent = close

    local minimize = Instance.new("TextButton")
    minimize.Name = "minimize"
    minimize.Parent = buttons
    minimize.BackgroundColor3 = Theme.Colors.Minimize
    minimize.Size = UDim2.new(0, 16, 0, 16)
    minimize.AutoButtonColor = false
    minimize.Text = ""

    minimize.MouseButton1Click:Connect(function()
        if UserInputService.TouchEnabled then
            window:ToggleVisible()
        end
    end)

    local uc_19 = Instance.new("UICorner")
    uc_19.CornerRadius = Theme.Sizes.FullRadius
    uc_19.Parent = minimize

    local resize = Instance.new("TextButton")
    resize.Name = "resize"
    resize.Parent = buttons
    resize.BackgroundColor3 = Theme.Colors.Resize
    resize.Size = UDim2.new(0, 16, 0, 16)
    resize.AutoButtonColor = false
    resize.Text = ""

    local uc_20 = Instance.new("UICorner")
    uc_20.CornerRadius = Theme.Sizes.FullRadius
    uc_20.Parent = resize
    
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Parent = workarea
    topBar.BackgroundTransparency = 1
    topBar.Position = UDim2.new(0, 20, 0, 15)
    topBar.Size = UDim2.new(1, -40, 0, 60)
    topBar.ZIndex = 3

    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Parent = topBar
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Font = Theme.Fonts.Title
    title.Text = ti or "UI Library"
    title.TextColor3 = Theme.Colors.TextDark
    title.TextSize = 30
    title.TextXAlignment = Enum.TextXAlignment.Left

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Parent = topBar
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 0, 0, 35)
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Font = Theme.Fonts.Body
    subtitle.Text = sub_ti or "User Interface"
    subtitle.TextColor3 = Theme.Colors.Text
    subtitle.TextSize = 16
    subtitle.TextXAlignment = Enum.TextXAlignment.Left

    local notif = Instance.new("Frame")
    notif.Name = "notif"
    notif.Parent = main
    notif.AnchorPoint = Vector2.new(0.5, 0.5)
    notif.BackgroundColor3 = Theme.Colors.ContentBack
    notif.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif.Size = UDim2.new(0, 304, 0, 362)
    notif.Visible = false
    notif.ZIndex = 200

    local uc_11 = Instance.new("UICorner")
    uc_11.CornerRadius = Theme.Sizes.LargeRadius
    uc_11.Parent = notif

    local notificon = Instance.new("ImageLabel")
    notificon.Name = "notificon"
    notificon.Parent = notif
    notificon.BackgroundTransparency = 1
    notificon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notificon.Size = UDim2.new(0, 100, 0, 100)
    notificon.ZIndex = 201
    notificon.Image = "rbxassetid://4871684504"
    notificon.ImageColor3 = Theme.Colors.Text

    local notifbutton1 = Instance.new("TextButton")
    notifbutton1.Name = "notifbutton1"
    notifbutton1.Parent = notif
    notifbutton1.BackgroundColor3 = Theme.Colors.Primary
    notifbutton1.Position = UDim2.new(0.0559210554, 0, 0.817679524, 0)
    notifbutton1.Size = UDim2.new(0, 270, 0, 50)
    notifbutton1.ZIndex = 201
    notifbutton1.Font = Theme.Fonts.Body
    notifbutton1.Text = "OK"
    notifbutton1.TextColor3 = Theme.Colors.TextLight
    notifbutton1.TextSize = 21

    local uc_12 = Instance.new("UICorner")
    uc_12.CornerRadius = Theme.Sizes.SmallRadius
    uc_12.Parent = notifbutton1

    notifdarkness = Instance.new("Frame")
    notifdarkness.Name = "notifdarkness"
    notifdarkness.Parent = main 
    notifdarkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notifdarkness.BackgroundColor3 = Theme.Colors.Shadow
    notifdarkness.BackgroundTransparency = 0.600
    notifdarkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifdarkness.Size = UDim2.new(1, 0, 1, 0) 
    notifdarkness.ZIndex = 199
    notifdarkness.Visible = false 

    local uc_13 = Instance.new("UICorner")
    uc_13.CornerRadius = Theme.Sizes.LargeRadius
    uc_13.Parent = notifdarkness

    local notifshadow = Instance.new("ImageLabel")
    notifshadow.Name = "notifshadow"
    notifshadow.Parent = notifdarkness 
    notifshadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notifshadow.BackgroundTransparency = 1
    notifshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notifshadow.Size = UDim2.new(1, 0, 1, 0) 
    notifshadow.ZIndex = notifdarkness.ZIndex - 1
    notifshadow.Image = "rbxassetid://313486536"
    notifshadow.ImageColor3 = Theme.Colors.Shadow
    notifshadow.ScaleType = Enum.ScaleType.Slice
    notifshadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local notiftitle = Instance.new("TextLabel")
    notiftitle.Name = "notiftitle"
    notiftitle.Parent = notif
    notiftitle.BackgroundTransparency = 1
    notiftitle.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notiftitle.Size = UDim2.new(0, 200, 0, 50)
    notiftitle.ZIndex = 201
    notiftitle.Font = Theme.Fonts.Title
    notiftitle.Text = "Notice"
    notiftitle.TextColor3 = Theme.Colors.TextDark
    notiftitle.TextSize = 28

    local notiftext = Instance.new("TextLabel")
    notiftext.Name = "notiftext"
    notiftext.Parent = notif
    notiftext.BackgroundTransparency = 1
    notiftext.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notiftext.Size = UDim2.new(0, 254, 0, 66)
    notiftext.ZIndex = 201
    notiftext.Font = Theme.Fonts.Body
    notiftext.Text = "We would like to contact you regarding your car's extended warranty."
    notiftext.TextColor3 = Theme.Colors.Text
    notiftext.TextSize = 16
    notiftext.TextWrapped = true

    local notif2 = Instance.new("Frame")
    notif2.Name = "notif2"
    notif2.Parent = main
    notif2.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2.BackgroundColor3 = Theme.Colors.ContentBack
    notif2.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2.Size = UDim2.new(0, 304, 0, 362)
    notif2.Visible = false
    notif2.ZIndex = 200

    local uc_14 = Instance.new("UICorner")
    uc_14.CornerRadius = Theme.Sizes.LargeRadius
    uc_14.Parent = notif2

    local notif2icon = Instance.new("ImageLabel")
    notif2icon.Name = "notif2icon"
    notif2icon.Parent = notif2
    notif2icon.BackgroundTransparency = 1
    notif2icon.Position = UDim2.new(0.335526317, 0, 0.0994475111, 0)
    notif2icon.Size = UDim2.new(0, 100, 0, 100)
    notif2icon.ZIndex = 201
    notif2icon.Image = "rbxassetid://12608260095"
    notif2icon.ImageColor3 = Theme.Colors.Text

    local notif2title = Instance.new("TextLabel")
    notif2title.Name = "notif2title"
    notif2title.Parent = notif2
    notif2title.BackgroundTransparency = 1
    notif2title.Position = UDim2.new(0.167763159, 0, 0.375690609, 0)
    notif2title.Size = UDim2.new(0, 200, 0, 50)
    notif2title.ZIndex = 201
    notif2title.Font = Theme.Fonts.Title
    notif2title.Text = "Notice"
    notif2title.TextColor3 = Theme.Colors.TextDark
    notif2title.TextSize = 28

    local notif2text = Instance.new("TextLabel")
    notif2text.Name = "notif2text"
    notif2text.Parent = notif2
    notif2text.BackgroundTransparency = 1
    notif2text.Position = UDim2.new(0.0822368413, 0, 0.513812184, 0)
    notif2text.Size = UDim2.new(0, 254, 0, 66)
    notif2text.ZIndex = 201
    notif2text.Font = Theme.Fonts.Body
    notif2text.Text = "We would like to contact you regarding your car's extended warranty."
    notif2text.TextColor3 = Theme.Colors.Text
    notif2text.TextSize = 16
    notif2text.TextWrapped = true

    local notif2button1 = Instance.new("TextButton")
    notif2button1.Name = "notif2button1"
    notif2button1.Parent = notif2
    notif2button1.BackgroundColor3 = Theme.Colors.Primary
    notif2button1.Position = UDim2.new(0.0559210517, 0, 0.715469658, 0)
    notif2button1.Size = UDim2.new(0, 270, 0, 40)
    notif2button1.ZIndex = 201
    notif2button1.Font = Theme.Fonts.Body
    notif2button1.Text = "Sure!"
    notif2button1.TextColor3 = Theme.Colors.TextLight
    notif2button1.TextSize = 21

    local uc_15 = Instance.new("UICorner")
    uc_15.CornerRadius = Theme.Sizes.SmallRadius
    uc_15.Parent = notif2button1

    notif2darkness = Instance.new("Frame")
    notif2darkness.Name = "notif2darkness"
    notif2darkness.Parent = main 
    notif2darkness.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2darkness.BackgroundColor3 = Theme.Colors.Shadow
    notif2darkness.BackgroundTransparency = 0.600
    notif2darkness.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2darkness.Size = UDim2.new(1, 0, 1, 0) 
    notif2darkness.ZIndex = 199
    notif2darkness.Visible = false 

    local uc_16 = Instance.new("UICorner")
    uc_16.CornerRadius = Theme.Sizes.LargeRadius
    uc_16.Parent = notif2darkness

    local notif2shadow = Instance.new("ImageLabel")
    notif2shadow.Name = "notif2shadow"
    notif2shadow.Parent = notif2darkness 
    notif2shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    notif2shadow.BackgroundTransparency = 1
    notif2shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    notif2shadow.Size = UDim2.new(1, 0, 1, 0) 
    notif2shadow.ZIndex = notif2darkness.ZIndex - 1
    notif2shadow.Image = "rbxassetid://313486536"
    notif2shadow.ImageColor3 = Theme.Colors.Shadow
    notif2shadow.ScaleType = Enum.ScaleType.Slice
    notif2shadow.SliceCenter = Rect.new(100, 100, 100, 100)

    local notif2button2 = Instance.new("TextButton")
    notif2button2.Name = "notif2button2"
    notif2button2.Parent = notif2
    notif2button2.BackgroundColor3 = Theme.Colors.Primary
    notif2button2.BackgroundTransparency = 1
    notif2button2.Position = UDim2.new(0.0526315793, 0, 0.842541456, 0)
    notif2button2.Size = UDim2.new(0, 270, 0, 40)
    notif2button2.ZIndex = 201
    notif2button2.Font = Theme.Fonts.Body
    notif2button2.Text = "Go away."
    notif2button2.TextColor3 = Theme.Colors.Text
    notif2button2.TextSize = 21

    local uc_17 = Instance.new("UICorner")
    uc_17.CornerRadius = Theme.Sizes.SmallRadius
    uc_17.Parent = notif2button2
    
    updateLoadingProgress("Finalizing...", 1.0)
    task.wait(0.8)
    
    if loadingScreen then
        tp(loadingScreen, UDim2.new(0.5, 0, -0.5, 0), 0.5)
        local blur = game:GetService("Lighting"):FindFirstChild("MacOsLibBlur")
        if blur then
            local tween = TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0})
            tween.Completed:Connect(function()
                blur:Destroy()
            end)
            tween:Play()
        end
        Debris:AddItem(loadingScreen, 0.5)
    end

    tp(main, UDim2.new(0.5, 0, 0.5, 0), 0.8)

    function window:ToggleVisible()
        if dbcooper then return end
        visible = not visible
        dbcooper = true
        if visible then
            hiddenIndicator.Size = collapsedSize
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Visible = false
                tp(hiddenIndicator, UDim2.new(1, 190, 0.7, 0), 0.3)
            else 
                mobileIndicator.Visible = false
            end
            tp(main, UDim2.new(0.5, 0, 0.5, 0), 0.5)
            hiText.Visible = false
            task.wait(0.5)
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Visible = false
            end
            dbcooper = false
        else
            tp(main, main.Position + UDim2.new(0, 0, 2, 0), 0.5)
            task.wait(0.5)
            if not UserInputService.TouchEnabled then
                hiddenIndicator.Size = collapsedSize
                hiddenIndicator.Visible = true
                tp(hiddenIndicator, UDim2.new(1, -10, 0.7, 0), 0.3) 
            else
                mobileIndicator.Visible = true
            end
            UserInputService.MouseIcon = ""
            dbcooper = false
        end
    end

    if visiblekey then
        minimize.MouseButton1Click:Connect(function()
            if not UserInputService.TouchEnabled then
                window:ToggleVisible()
            end
        end)
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == visiblekey then
                window:ToggleVisible()
            end
        end)
    end

    function window:GreenButton(callback)
        if window.greenButtonConnection then 
            window.greenButtonConnection:Disconnect() 
        end
        
        window.greenButtonConnection = resize.MouseButton1Click:Connect(function()
            isMaximized = not isMaximized
            local tweenTime = 0.3
            local tween
            
            if isMaximized then
                originalSize = main.AbsoluteSize
                originalPosition = main.Position
                
                local viewportSize = workspace.CurrentCamera.ViewportSize
                local newSize = viewportSize * 0.9
                local newPos = UDim2.new(0.5, 0, 0.5, 0)
                
                tween = TweenService:Create(main, TweenInfo.new(tweenTime), {Size = UDim2.new(0, newSize.X, 0, newSize.Y), Position = newPos})
                
            else
                if not originalSize then isMaximized = false; return end
                tween = TweenService:Create(main, TweenInfo.new(tweenTime), {Size = UDim2.new(0, originalSize.X, 0, originalSize.Y), Position = originalPosition})
            end
            
            tween:Play()
            tween.Completed:Wait()
            RunService.Heartbeat:Wait() -- Wait one frame for AbsoluteSize to propagate

            for i, section in ipairs(sections) do
                local workarea = workareas[i]
                if workarea and workarea.Visible then
                    local secAPI = sectionAPIs[i]
                    if secAPI and secAPI.Select then
                        secAPI:Select()
                    end
                end
            end

            if callback then
                task.spawn(callback, isMaximized)
            end
        end)
    end

    function window:TempNotify(text1, text2, icon)
        for b, v in next, scrgui:GetChildren() do
            if v.Name == "tempnotif" then
                v.Position += UDim2.new(0, 0, 0, 130)
            end
        end
        local tempnotif = Instance.new("Frame")
        tempnotif.Name = "tempnotif"
        tempnotif.Parent = scrgui
        tempnotif.AnchorPoint = Vector2.new(0.5, 0.5)
        tempnotif.BackgroundColor3 = Theme.Colors.MainBack
        tempnotif.BackgroundTransparency = 0.150
        tempnotif.Position = UDim2.new(1, -250, 0.0794737339, 0)
        tempnotif.Size = UDim2.new(0, 447, 0, 117)
        tempnotif.Visible = true
        tempnotif.ZIndex = 4

        local uc_21 = Instance.new("UICorner")
        uc_21.CornerRadius = Theme.Sizes.LargeRadius
        uc_21.Parent = tempnotif

        local t2 = Instance.new("TextLabel")
        t2.Name = "t2"
        t2.Parent = tempnotif
        t2.BackgroundTransparency = 1
        t2.Position = UDim2.new(0.236927822, 0, 0.470085472, 0)
        t2.Size = UDim2.new(0, 326, 0, 52)
        t2.ZIndex = 4
        t2.Font = Theme.Fonts.Body
        t2.Text = text2
        t2.TextColor3 = Theme.Colors.Text
        t2.TextSize = 16
        t2.TextWrapped = true
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextYAlignment = Enum.TextYAlignment.Top

        local t1 = Instance.new("TextLabel")
        t1.Name = "t1"
        t1.Parent = tempnotif
        t1.BackgroundTransparency = 1
        t1.Position = UDim2.new(0.234690696, 0, 0.193464488, 0)
        t1.Size = UDim2.new(0, 327, 0, 25)
        t1.ZIndex = 4
        t1.Font = Theme.Fonts.Title
        t1.Text = text1
        t1.TextColor3 = Theme.Colors.TextDark
        t1.TextSize = 28
        t1.TextXAlignment = Enum.TextXAlignment.Left

        local ticon = Instance.new("ImageLabel")
        ticon.Name = "ticon"
        ticon.Parent = tempnotif
        ticon.BackgroundTransparency = 1
        ticon.Position = UDim2.new(0.0311112702, 0, 0.193464488, 0)
        ticon.Size = UDim2.new(0, 71, 0, 71)
        ticon.ZIndex = 4
        ticon.Image = icon
        ticon.ImageColor3 = Theme.Colors.Text
        ticon.ScaleType = Enum.ScaleType.Fit

    local tshadow = Instance.new("ImageLabel")
        tshadow.Name = "tshadow"
        tshadow.Parent = tempnotif
        tshadow.AnchorPoint = Vector2.new(0.5, 0.5)
        tshadow.BackgroundTransparency = 1
        tshadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        tshadow.Size = UDim2.new(1.12, 0, 1.2, 0)
        tshadow.ZIndex = 3
        tshadow.Image = "rbxassetid://313486536"
        tshadow.ImageColor3 = Theme.Colors.Shadow
        tshadow.ImageTransparency = 0.400
        
        Debris:AddItem(tempnotif, 5)
    end

    function window:Notify(txt1, txt2, b1, icohn, callback)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notiftitle.Text = txt1
        notiftext.Text = txt2
        notificon.Image = icohn
        notif.Visible = true
        notifdarkness.Visible = true
        notifbutton1.Text = b1
        
        local con1
        con1 = notifbutton1.MouseButton1Click:Connect(function()
            if con1 then con1:Disconnect() end
            if callback then
                callback()
            end
            notif.Visible = false
            notifdarkness.Visible = false
        end)
    end


    function window:Notify2(txt1, txt2, b1, b2, icohn, callback, callback2, b1Color)
        if notif.Visible == true or notif2.Visible == true then return "Already visible" end
        notif2title.Text = txt1
        notif2text.Text = txt2
        notif2icon.Image = icohn
        notif2.Visible = true
        notif2darkness.Visible = true
        notif2button1.Text = b1
        notif2button2.Text = b2
        

        notif2button1.BackgroundColor3 = b1Color or Theme.Colors.Primary
        
        local con1, con2
        con1 = notif2button1.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            if callback then callback() end
            notif2.Visible = false
            notif2darkness.Visible = false
        end)
        con2 = notif2button2.MouseButton1Click:Connect(function()
            con1:Disconnect()
            con2:Disconnect()
            if callback2 then callback2() end
            notif2.Visible = false
            notif2darkness.Visible = false
        end)
    end


    function window:Divider(name)
        local sidebardivider = Instance.new("TextLabel")
        sidebardivider.Name = "sidebardivider"
        sidebardivider.Parent = sidebar
        sidebardivider.BackgroundTransparency = 1
        sidebardivider.Size = UDim2.new(1, 0, 0, 26)
        sidebardivider.Font = Theme.Fonts.Body
        sidebardivider.Text = name
        sidebardivider.TextColor3 = Theme.Colors.Text
        sidebardivider.TextSize = 16
        sidebardivider.TextWrapped = true
        sidebardivider.TextXAlignment = Enum.TextXAlignment.Left
        sidebardivider.TextYAlignment = Enum.TextYAlignment.Bottom
        
        local pad = Instance.new("UIPadding", sidebardivider)
        pad.PaddingLeft = UDim.new(0, 10)
    end


    function window:Section(name, subtitle, icon)
        local sidebar2 = Instance.new("TextButton")
        sidebar2.Name = "sidebar2"
        sidebar2.Parent = sidebar
        sidebar2.BackgroundColor3 = Theme.Colors.Primary
        sidebar2.BackgroundTransparency = 1
        sidebar2.Size = UDim2.new(1, 0, 0, 50)
        sidebar2.ZIndex = 2
        sidebar2.AutoButtonColor = false
        sidebar2.Text = ""


        local selectionBar = Instance.new("Frame")
        selectionBar.Name = "SelectionBar"
        selectionBar.Parent = sidebar2
        selectionBar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
        selectionBar.BorderSizePixel = 0
        selectionBar.Size = UDim2.new(0, 3, 0.8, 0)
        selectionBar.Position = UDim2.new(1, -3, 0.1, 0)
        selectionBar.Visible = false
        local sbCorner = Instance.new("UICorner", selectionBar)
        sbCorner.CornerRadius = Theme.Sizes.FullRadius
        createGradient(selectionBar, Color3.fromRGB(139, 92, 246), Color3.fromRGB(160, 120, 255))


        local sectionIcon = Instance.new("ImageLabel")
        sectionIcon.Name = "SectionIcon"
        sectionIcon.Parent = sidebar2
        sectionIcon.BackgroundTransparency = 1
        sectionIcon.Position = UDim2.new(0, 15, 0.5, 0)
        sectionIcon.AnchorPoint = Vector2.new(0, 0.5)
        sectionIcon.Size = UDim2.new(0, 22, 0, 22)
        sectionIcon.ZIndex = 3
        sectionIcon.Image = icon
        sectionIcon.ImageColor3 = Theme.Colors.Text
        sectionIcon.ScaleType = Enum.ScaleType.Fit
        

        local sectionTitle = Instance.new("TextLabel")
        sectionTitle.Name = "SectionTitle"
        sectionTitle.Parent = sidebar2
        sectionTitle.BackgroundTransparency = 1
        sectionTitle.Font = Theme.Fonts.Title
        sectionTitle.Text = name
        sectionTitle.TextColor3 = Theme.Colors.Text
        sectionTitle.TextSize = 18
        sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionTitle.ZIndex = 3
        sectionTitle.Position = UDim2.new(0, 48, 0.5, -9)
        sectionTitle.AnchorPoint = Vector2.new(0, 0.5)
        sectionTitle.Size = UDim2.new(1, -75, 0, 20)
        

        local sectionSubtitle = Instance.new("TextLabel")
        sectionSubtitle.Name = "SectionSubtitle"
        sectionSubtitle.Parent = sidebar2
        sectionSubtitle.BackgroundTransparency = 1
        sectionSubtitle.Font = Theme.Fonts.Body
        sectionSubtitle.Text = subtitle
        sectionSubtitle.TextColor3 = Theme.Colors.Gray
        sectionSubtitle.TextSize = 14
        sectionSubtitle.TextXAlignment = Enum.TextXAlignment.Left
        sectionSubtitle.ZIndex = 3
        sectionSubtitle.Position = UDim2.new(0, 48, 0.5, 9)
        sectionSubtitle.AnchorPoint = Vector2.new(0, 0.5)
        sectionSubtitle.Size = UDim2.new(1, -75, 0, 16)
        
        table.insert(sections, sidebar2)

        local workareamain = Instance.new("ScrollingFrame")
        workareamain.Name = "workareamain"
        workareamain.Parent = workarea
        workareamain.Active = true
        workareamain.BackgroundTransparency = 1
        workareamain.BorderSizePixel = 0 
        workareamain.Position = UDim2.new(0, 20, 0, 85)
        workareamain.Size = UDim2.new(1, -40, 1, -100)
        workareamain.ZIndex = 3
        workareamain.AutomaticCanvasSize = "Y"
        workareamain.CanvasSize = UDim2.new(0, 0, 0, 0)
        workareamain.ScrollBarThickness = 3
        workareamain.ScrollBarImageColor3 = Theme.Colors.Text
        workareamain.Visible = false
        
        local pad = Instance.new("UIPadding", workareamain)
        pad.Name = "pad"
        pad.PaddingTop = UDim.new(0, 10)
        pad.PaddingRight = UDim.new(0, 10)

        local ull = Instance.new("UIListLayout")
        ull.Parent = workareamain
        ull.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ull.SortOrder = Enum.SortOrder.LayoutOrder
        ull.Padding = UDim.new(0, 8)

        table.insert(workareas, workareamain)

        local sec = {}
        local layoutOrderCounter = 0
        

        function sec:Select()
            for b, v in next, sections do

                v:FindFirstChild("SelectionBar").Visible = false
                local title = v:FindFirstChild("SectionTitle")
                local subtitle = v:FindFirstChild("SectionSubtitle")
                local iconInstance = v:FindFirstChild("SectionIcon")

                if title then title.TextColor3 = Theme.Colors.Text end
                if subtitle then subtitle.TextColor3 = Theme.Colors.Gray end
                if iconInstance then iconInstance.ImageColor3 = Theme.Colors.Text end
            end
            

            selectionBar.Visible = true 
            local currentTitle = sidebar2:FindFirstChild("SectionTitle")
            local currentSubtitle = sidebar2:FindFirstChild("SectionSubtitle")
            local selectedIcon = sidebar2:FindFirstChild("SectionIcon")

            if currentTitle then currentTitle.TextColor3 = Theme.Colors.TextDark end
            if currentSubtitle then currentSubtitle.TextColor3 = Theme.Colors.Text end
            if selectedIcon then selectedIcon.ImageColor3 = Color3.fromRGB(139, 92, 246) end


            if activeWorkarea ~= workareamain then
                local oldWorkarea = activeWorkarea
                activeWorkarea = workareamain

                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                local targetInPosition = UDim2.new(0, 20, 0, 85)

                workareamain.ZIndex = 4
                workareamain.Position = UDim2.new(1, 20, 0, 85)
                workareamain.Visible = true
                TweenService:Create(workareamain, tweenInfo, {Position = targetInPosition}):Play()


                if oldWorkarea then
                    local targetOutPosition = UDim2.new(-1, 20, 0, 85)
                    TweenService:Create(oldWorkarea, tweenInfo, {Position = targetOutPosition}):Play()
                    task.delay(tweenInfo.Time, function()
                        if oldWorkarea and oldWorkarea.Parent and activeWorkarea ~= oldWorkarea then
                            oldWorkarea.Visible = false
                            oldWorkarea.ZIndex = 3
                        end
                    end)
                end
            end
            
            -- 1. Collect all existing items into a flat list
            local allItems = {}
            local oldContainer = workareamain:FindFirstChild("LayoutColumn_Container")
            if oldContainer then
                -- Collect from existing columns
                for _, column in ipairs(oldContainer:GetChildren()) do
                    if column.Name:find("LayoutColumn_") then
                        for _, item in ipairs(column:GetChildren()) do
                            if item:IsA("GuiObject") then table.insert(allItems, item) end
                        end
                    end
                end
            else
                -- Collect from single-column view
                for _, child in ipairs(workareamain:GetChildren()) do
                    -- Collect any GUI object that isn't a layout helper
                    if child:IsA("GuiObject") and not child:IsA("UILayout") and child.Name ~= "pad" then
                        table.insert(allItems, child)
                    end
                end
            end

            -- 2. Determine layout parameters
            local splitThreshold = 1 -- How many items are needed to justify splitting
            local itemCount = #allItems
            local workareaWidth = workareamain.AbsoluteSize.X
            local minColumnWidth = 300
            local numColumns
            
            if isMaximized then
                numColumns = math.max(1, math.floor(workareaWidth / minColumnWidth))
                pad.PaddingTop = UDim.new(0, 25)
            else
                numColumns = 1
                pad.PaddingTop = UDim.new(0, 10)
            end

            -- 3. Detach all items and current layouts
            for _, item in ipairs(allItems) do item.Parent = nil end
            if oldContainer then oldContainer:Destroy() end
            if ull then ull.Parent = nil end -- ull is the single-column layout

            -- 4. Sort items by their original layout order
            table.sort(allItems, function(a, b) return a.LayoutOrder < b.LayoutOrder end)

            -- 5. Apply the new layout
            if numColumns > 1 and itemCount > splitThreshold then
                -- APPLY MULTI-COLUMN LAYOUT
                local columnsContainer = Instance.new("Frame", workareamain)
                columnsContainer.Name = "LayoutColumn_Container"
                columnsContainer.BackgroundTransparency = 1
                columnsContainer.Size = UDim2.new(1, 0, 0, 0)
                columnsContainer.AutomaticSize = Enum.AutomaticSize.Y
                
                local columnsLayout = Instance.new("UIListLayout", columnsContainer)
                columnsLayout.FillDirection = Enum.FillDirection.Horizontal
                columnsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                columnsLayout.Padding = UDim.new(0, 20)
                
                local columns = {}
                local columnPadding = columnsLayout.Padding.Offset * (numColumns - 1)
                local columnWidth = UDim2.new(1 / numColumns, -columnPadding / numColumns, 0, 0)
                
                for i = 1, numColumns do
                    local column = Instance.new("Frame", columnsContainer)
                    column.Name = "LayoutColumn_" .. i
                    column.BackgroundTransparency = 1
                    column.Size = columnWidth
                    column.AutomaticSize = Enum.AutomaticSize.Y
                    
                    local columnListLayout = Instance.new("UIListLayout", column)
                    columnListLayout.Padding = UDim.new(0, 8)
                    columnListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    table.insert(columns, column)
                end
                
                -- Distribute items into columns (vertical fill)
                local itemsPerColumn = math.ceil(#allItems / numColumns)
                for i, item in ipairs(allItems) do
                    local columnIndex = math.floor((i - 1) / itemsPerColumn) + 1
                    columnIndex = math.min(columnIndex, numColumns)
                    item.Parent = columns[columnIndex]
                end
            else
                -- APPLY SINGLE-COLUMN LAYOUT
                for _, item in ipairs(allItems) do item.Parent = workareamain end
                if ull then ull.Parent = workareamain end
            end

            -- 6. Reset scroll position
            RunService.Heartbeat:Wait()
            workareamain.CanvasSize = UDim2.new()
            workareamain.CanvasPosition = Vector2.new(0,0)
        end
        
        table.insert(sectionAPIs, sec)

        function sec:Section(sectionName, startClosed)
            layoutOrderCounter = layoutOrderCounter + 1
            local sectionLayoutOrderCounter = 0
            local section = {}
            local collapsed = startClosed or false

            local SectionContainer = Instance.new("Frame")
            SectionContainer.Name = sectionName .. "_Section"
            SectionContainer.Parent = workareamain
            SectionContainer.BackgroundColor3 = Theme.Colors.SectionBack
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.AutomaticSize = Enum.AutomaticSize.Y
            SectionContainer.LayoutOrder = layoutOrderCounter
            SectionContainer.ClipsDescendants = false
            local sc_uc = Instance.new("UICorner", SectionContainer)
            sc_uc.CornerRadius = Theme.Sizes.SmallRadius

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionContainer
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 0)

           -- Header Button (Click to toggle)
            local SectionHeader = Instance.new("TextButton")
            SectionHeader.Name = "Header"
            SectionHeader.Parent = SectionContainer
            SectionHeader.BackgroundColor3 = Theme.Colors.SectionBack
            SectionHeader.BackgroundTransparency = 0  -- CHANGED: Make background visible
            SectionHeader.Size = UDim2.new(1, 0, 0, 40)  -- CHANGED: Increased from 35 to 40
            SectionHeader.AutoButtonColor = false
            SectionHeader.Font = Theme.Fonts.Title
            SectionHeader.Text = "  " .. sectionName
            SectionHeader.TextColor3 = Theme.Colors.Text
            SectionHeader.TextSize = 14  -- CHANGED: Increased from 13 to 14
            SectionHeader.TextXAlignment = Enum.TextXAlignment.Left
            SectionHeader.ClipsDescendants = false  -- ADDED: Don't clip content
            local sh_uc = Instance.new("UICorner", SectionHeader)
            sh_uc.CornerRadius = Theme.Sizes.SmallRadius

            local ArrowIcon = Instance.new("ImageLabel")
            ArrowIcon.Name = "Arrow"
            ArrowIcon.Parent = SectionHeader
            ArrowIcon.AnchorPoint = Vector2.new(1, 0.5)
            ArrowIcon.BackgroundTransparency = 1
            ArrowIcon.Position = UDim2.new(1, -10, 0.5, 0)
            ArrowIcon.Size = UDim2.new(0, 16, 0, 16)
            ArrowIcon.Image = "rbxassetid://6031090990" -- Down arrow asset
            ArrowIcon.ImageColor3 = Theme.Colors.Text
            ArrowIcon.Rotation = collapsed and -90 or 0 -- 0 is expanded, -90 is collapsed

            -- Content Holder
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Parent = SectionContainer
            SectionContent.BackgroundColor3 = Theme.Colors.SectionBack
            SectionContent.BackgroundTransparency = 1
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            SectionContent.ClipsDescendants = true
            SectionContent.Visible = not collapsed -- start based on collapsed state

            local SectionContentLayout = Instance.new("UIListLayout")
            SectionContentLayout.Parent = SectionContent
            SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionContentLayout.Padding = UDim.new(0, 8)

            local SectionContentPadding = Instance.new("UIPadding")
            SectionContentPadding.Parent = SectionContent
            SectionContentPadding.PaddingTop = UDim.new(0, 5)
            SectionContentPadding.PaddingBottom = UDim.new(0, 10)
            SectionContentPadding.PaddingLeft = UDim.new(0, 10)
            SectionContentPadding.PaddingRight = UDim.new(0, 10)

            -- Toggle Logic
            local tweening = false
            SectionHeader.MouseButton1Click:Connect(function()
                if tweening then return end
                tweening = true

                collapsed = not collapsed
                local targetRotation = collapsed and -90 or 0
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

                TweenService:Create(ArrowIcon, tweenInfo, {Rotation = targetRotation}):Play()

                if collapsed then
                    -- COLLAPSING
                    local currentHeight = SectionContent.AbsoluteSize.Y
                    SectionContent.AutomaticSize = Enum.AutomaticSize.None
                    SectionContent.Size = UDim2.new(1, 0, 0, currentHeight)

                    local tween = TweenService:Create(SectionContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)})
                    tween.Completed:Connect(function()
                        SectionContent.Visible = false
                        SectionContent.AutomaticSize = Enum.AutomaticSize.Y -- Reset for next expansion
                        tweening = false
                    end)
                    tween:Play()
                else
                    -- EXPANDING
                    -- To prevent flicker, we calculate the target height using an off-screen clone
                    local clone = SectionContent:Clone()
                    clone.Parent = scrgui
                    clone.Position = UDim2.new(5, 0, 5, 0) -- Position it way off-screen
                    clone.AutomaticSize = Enum.AutomaticSize.Y
                    clone.Visible = true
                    
                    RunService.Heartbeat:Wait() -- Let the clone calculate its size
                    
                    local targetHeight = clone.AbsoluteSize.Y
                    clone:Destroy()

                    -- Now, animate the actual SectionContent frame, which is starting at size 0
                    SectionContent.Visible = true
                    SectionContent.AutomaticSize = Enum.AutomaticSize.None
                    SectionContent.Size = UDim2.new(1, 0, 0, 0)

                    local tween = TweenService:Create(SectionContent, tweenInfo, {Size = UDim2.new(1, 0, 0, targetHeight)})
                    tween.Completed:Connect(function()
                        SectionContent.AutomaticSize = Enum.AutomaticSize.Y -- Let it manage its own size again
                        tweening = false
                    end)
                    tween:Play()
                end
            end)

            function section:Button(text, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local button = Instance.new("TextButton")
                button.Name = "button"
                button.Parent = SectionContent
                button.BackgroundColor3 = Theme.Colors.ElementBack
                button.Size = UDim2.new(1, 0, 0, 32)
                button.ZIndex = 2
                button.Font = Theme.Fonts.Body
                button.Text = text or "Button"
                button.TextColor3 = Theme.Colors.Text
                button.TextSize = 14
                button.AutoButtonColor = false
                button.LayoutOrder = sectionLayoutOrderCounter

                local uc_3 = Instance.new("UICorner")
                uc_3.CornerRadius = Theme.Sizes.SmallRadius
                uc_3.Parent = button

                button.MouseEnter:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.Hover}):Play()
                end)

                button.MouseLeave:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                end)

                if callback then
                    button.MouseButton1Click:Connect(function()
                        TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Colors.Primary}):Play()
                        task.wait(0.1)
                        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                        task.spawn(callback)
                    end)
                end
            end

            function section:Label(name)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local label = Instance.new("TextLabel")
                label.Name = "label"
                label.Parent = SectionContent
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, 0, 0, 37)
                label.Font = Theme.Fonts.Body
                label.TextColor3 = Theme.Colors.Text
                label.TextSize = 14
                label.TextWrapped = true
                label.Text = name
                label.LayoutOrder = sectionLayoutOrderCounter
                label.TextXAlignment = Enum.TextXAlignment.Left
            end

            function section:Switch(text, default, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local toggled = default or false
                
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Name = "toggleswitch"
                ToggleFrame.Parent = SectionContent
                ToggleFrame.BackgroundColor3 = Theme.Colors.ElementBack
                ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
                ToggleFrame.AutoButtonColor = false
                ToggleFrame.Text = ""
                ToggleFrame.LayoutOrder = sectionLayoutOrderCounter
                local corner = Instance.new("UICorner", ToggleFrame)
                corner.CornerRadius = Theme.Sizes.SmallRadius

                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
                ToggleLabel.Font = Theme.Fonts.Body
                ToggleLabel.Text = text or "Switch"
                ToggleLabel.TextColor3 = Theme.Colors.Text
                ToggleLabel.TextSize = 14
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleIndicator = Instance.new("Frame")
                ToggleIndicator.Parent = ToggleFrame
                ToggleIndicator.AnchorPoint = Vector2.new(1, 0.5)
                ToggleIndicator.BackgroundColor3 = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                ToggleIndicator.Position = UDim2.new(1, -10, 0.5, 0)
                ToggleIndicator.Size = UDim2.new(0, 36, 0, 18)
                local indCorner = Instance.new("UICorner", ToggleIndicator)
                indCorner.CornerRadius = UDim.new(1,0)
                local indStroke = Instance.new("UIStroke", ToggleIndicator)
                indStroke.Color = Theme.Colors.Border
                indStroke.Thickness = 1
                indStroke.Parent = ToggleIndicator

                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Parent = ToggleIndicator
                ToggleCircle.BackgroundColor3 = Theme.Colors.Text
                ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
                local circCorner = Instance.new("UICorner", ToggleCircle)
                circCorner.CornerRadius = UDim.new(1,0)

                local offPos = UDim2.new(0, 2, 0, 2)
                local onPos = UDim2.new(0, 20, 0, 2)
                ToggleCircle.Position = toggled and onPos or offPos

                ToggleFrame.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    local targetColor = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                    local targetPos = toggled and onPos or offPos

                    TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
                    if callback then
                        task.spawn(callback, toggled)
                    end
                end)
            end

            function section:TextField(text, placeholder, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                
                local textfield = Instance.new("TextLabel")
                textfield.Name = "textfield"
                textfield.Parent = SectionContent
                textfield.BackgroundTransparency = 1
                textfield.Size = UDim2.new(1, 0, 0, 37)
                textfield.Font = Theme.Fonts.Body
                textfield.Text = text
                textfield.TextColor3 = Theme.Colors.Text
                textfield.TextSize = 14
                textfield.TextWrapped = true
                textfield.TextXAlignment = Enum.TextXAlignment.Left
                textfield.LayoutOrder = sectionLayoutOrderCounter
                
                local Frame_2 = Instance.new("Frame")
                Frame_2.Parent = textfield
                Frame_2.BackgroundColor3 = Theme.Colors.ElementBack
                Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
                Frame_2.AnchorPoint = Vector2.new(0, 0.5)
                Frame_2.Size = UDim2.new(0.5, 0, 1, -6)

                local uc_6 = Instance.new("UICorner")
                uc_6.CornerRadius = Theme.Sizes.SmallRadius
                uc_6.Parent = Frame_2

                local TextBox = Instance.new("TextBox")
                TextBox.Parent = Frame_2
                TextBox.BackgroundTransparency = 1
                TextBox.BorderSizePixel = 0
                TextBox.ClipsDescendants = true
                TextBox.Position = UDim2.new(0, 10, 0, 0)
                TextBox.Size = UDim2.new(1, -20, 1, 0)
                TextBox.ClearTextOnFocus = false
                TextBox.Font = Theme.Fonts.Body
                TextBox.PlaceholderColor3 = Theme.Colors.TextDark
                TextBox.PlaceholderText = placeholder or "Type here..."
                TextBox.Text = ""
                TextBox.TextColor3 = Theme.Colors.Text
                TextBox.TextSize = 14
                TextBox.TextXAlignment = Enum.TextXAlignment.Left

                if callback then
                    TextBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            callback(TextBox.Text)
                        end
                    end)
                end
            end

            function section:Slider(text, min, max, default, callback)
                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                
                local sliderContainer = Instance.new("TextLabel")
                sliderContainer.Name = "slider"
                sliderContainer.Parent = SectionContent
                sliderContainer.BackgroundTransparency = 1
                sliderContainer.Size = UDim2.new(1, 0, 0, 50)
                sliderContainer.Font = Theme.Fonts.Body
                sliderContainer.Text = text or "Slider"
                sliderContainer.TextColor3 = Theme.Colors.Text
                sliderContainer.TextSize = 14
                sliderContainer.TextWrapped = true
                sliderContainer.TextXAlignment = Enum.TextXAlignment.Left
                sliderContainer.LayoutOrder = sectionLayoutOrderCounter
    
                local valueLabel = Instance.new("TextLabel")
                valueLabel.Name = "ValueLabel"
                valueLabel.Parent = sliderContainer
                valueLabel.BackgroundTransparency = 1
                valueLabel.Font = Theme.Fonts.Body
                valueLabel.TextColor3 = Theme.Colors.Text
                valueLabel.TextSize = 14
                valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    
                valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
                valueLabel.AnchorPoint = Vector2.new(0, 0)
                valueLabel.Size = UDim2.new(0.5, 0, 0, 20)
    
                local track = Instance.new("Frame")
                track.Name = "Track"
                track.Parent = sliderContainer
                track.BackgroundColor3 = Theme.Colors.ElementBack
    
                track.Position = UDim2.new(0.5, 0, 0.6, 0)
                track.AnchorPoint = Vector2.new(0, 0)
                track.Size = UDim2.new(0.5, 0, 0, 6)
                local trackCorner = Instance.new("UICorner", track)
                trackCorner.CornerRadius = Theme.Sizes.FullRadius
    
                local fill = Instance.new("Frame")
                fill.Name = "Fill"
                fill.Parent = track
                fill.BackgroundColor3 = Theme.Colors.Primary
                fill.Size = UDim2.new(0, 0, 1, 0)
                local fillCorner = Instance.new("UICorner", fill)
                fillCorner.CornerRadius = Theme.Sizes.FullRadius
                
                createGradient(fill, Theme.Colors.Primary, Theme.Colors.PrimaryLight)
    
                local thumb = Instance.new("TextButton")
                thumb.Name = "Thumb"
                thumb.Parent = track
                thumb.BackgroundColor3 = Theme.Colors.TextLight
                thumb.Size = UDim2.new(0, 16, 0, 16)
                thumb.AnchorPoint = Vector2.new(0.5, 0.5)
                thumb.Position = UDim2.new(0, 0, 0.5, 0)
                thumb.ZIndex = 3
                thumb.Text = ""
                local thumbCorner = Instance.new("UICorner", thumb)
                thumbCorner.CornerRadius = Theme.Sizes.FullRadius
                local thumbStroke = Instance.new("UIStroke", thumb)
                thumbStroke.Color = Theme.Colors.Gray
                thumbStroke.Thickness = 1
    
                local currentValue = default or (min or 0)
    
                local function updateSlider(value, runCallback)
                    local v_min = min or 0
                    local v_max = max or 100
                    currentValue = math.clamp(value, v_min, v_max)
                    local percentage = (currentValue - v_min) / (v_max - v_min)
                    
                    valueLabel.Text = tostring(math.floor(currentValue * 100) / 100) 
                    
                    local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(fill, tweenInfo, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                    TweenService:Create(thumb, tweenInfo, {Position = UDim2.new(percentage, 0, 0.5, 0)}):Play()
    
                    if runCallback and callback then
                        task.spawn(callback, currentValue)
                    end
                end
    
                thumb.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        local moveConn, releaseConn
                        moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                            local v_min = min or 0
                            local v_max = max or 100
                            local percentage = (moveInput.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                            local newValue = v_min + (v_max - v_min) * math.clamp(percentage, 0, 1)
                            updateSlider(newValue, true)
                        end)
                        releaseConn = UserInputService.InputEnded:Connect(function()
                            moveConn:Disconnect()
                            releaseConn:Disconnect()
                        end)
                    end
                end)
    
                updateSlider(currentValue, false)
            end

            function section:Dropdown(name, list, multi, p4, p5)
                local defaultValue, callback
                if type(p4) == 'function' and p5 == nil then
                    defaultValue = nil
                    callback = p4
                else
                    defaultValue = p4
                    callback = p5
                end

                sectionLayoutOrderCounter = sectionLayoutOrderCounter + 1
                local dropdown = Instance.new("TextLabel")
                dropdown.Name = "dropdown"
                dropdown.Parent = SectionContent
                dropdown.BackgroundTransparency = 1
                dropdown.Size = UDim2.new(1, 0, 0, 37)
                dropdown.Font = Theme.Fonts.Body
                dropdown.Text = name
                dropdown.TextColor3 = Theme.Colors.Text
                dropdown.TextSize = 14
                dropdown.TextXAlignment = Enum.TextXAlignment.Left
                dropdown.LayoutOrder = sectionLayoutOrderCounter
    
                local selectedItems = {}
                local isMultiSelect = multi or false
    
                local dropdownButton = Instance.new("TextButton")
                dropdownButton.Name = "DropdownButton"
                dropdownButton.Parent = dropdown
                dropdownButton.BackgroundColor3 = Theme.Colors.ElementBack
                dropdownButton.Position = UDim2.new(0.5, 0, 0.5, 0)
                dropdownButton.AnchorPoint = Vector2.new(0, 0.5)
                dropdownButton.Size = UDim2.new(0.5, 0, 1, -6)
                dropdownButton.Font = Theme.Fonts.Body
                dropdownButton.Text = (isMultiSelect and "Select") or (defaultValue or list[1] or "Select")

                -- Initialize selectedItems from defaultValue for multi-select
                if isMultiSelect and defaultValue and type(defaultValue) == "table" then
                    for _, item in ipairs(defaultValue) do
                        selectedItems[item] = true
                    end
                    if #defaultValue > 0 then
                        dropdownButton.Text = table.concat(defaultValue, ", ")
                    end
                end

                dropdownButton.TextColor3 = Theme.Colors.Text
                dropdownButton.TextSize = 14
                dropdownButton.ZIndex = 8
                dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                dropdownButton.TextTruncate = Enum.TextTruncate.AtEnd
    
                local textPadding = Instance.new("UIPadding", dropdownButton)
                textPadding.PaddingLeft = UDim.new(0, 10)
                textPadding.PaddingRight = UDim.new(0, 25)
                
                local uc_drop = Instance.new("UICorner", dropdownButton)
                uc_drop.CornerRadius = Theme.Sizes.SmallRadius
    
                local arrow = Instance.new("ImageLabel", dropdownButton)
                arrow.BackgroundTransparency = 1
                arrow.AnchorPoint = Vector2.new(0.5, 0.5)
                arrow.Position = UDim2.new(1, -15, 0.5, 0)
                arrow.Size = UDim2.new(0, 12, 0, 12)
                arrow.Image = "rbxassetid://3926305904"
                arrow.ImageColor3 = Theme.Colors.Text
    
                local optionsFrame = Instance.new("Frame")
                optionsFrame.Name = "OptionsFrame"
                optionsFrame.Parent = dropdown
                optionsFrame.BackgroundColor3 = Theme.Colors.SectionBack
                optionsFrame.BorderSizePixel = 0
                optionsFrame.Position = UDim2.new(0.5, 0, 1, 5) 
                optionsFrame.AnchorPoint = Vector2.new(0, 0)
                optionsFrame.Size = UDim2.new(0.5, 0, 0, 0) 
                optionsFrame.Visible = false
                optionsFrame.ZIndex = 20
                optionsFrame.ClipsDescendants = true
                
                local uc_options = Instance.new("UICorner", optionsFrame)
                uc_options.CornerRadius = Theme.Sizes.SmallRadius

                local searchContainer = Instance.new("Frame")
                searchContainer.Name = "SearchContainer"
                searchContainer.Parent = optionsFrame
                searchContainer.BackgroundColor3 = Theme.Colors.ElementBack
                searchContainer.Position = UDim2.new(0, 5, 0, 5)
                searchContainer.Size = UDim2.new(1, -10, 0, 25)
                searchContainer.ZIndex = 21
                local uc_search = Instance.new("UICorner", searchContainer)
                uc_search.CornerRadius = Theme.Sizes.SmallRadius

                local searchIcon = Instance.new("ImageLabel")
                searchIcon.Name = "SearchIcon"
                searchIcon.Parent = searchContainer
                searchIcon.BackgroundTransparency = 1
                searchIcon.Size = UDim2.new(0, 14, 0, 14)
                searchIcon.Position = UDim2.new(0, 6, 0.5, 0)
                searchIcon.AnchorPoint = Vector2.new(0, 0.5)
                searchIcon.Image = "rbxassetid://5036466001"
                searchIcon.ImageColor3 = Theme.Colors.Text
                searchIcon.ZIndex = 22

                local searchBar = Instance.new("TextBox")
                searchBar.Name = "SearchBar"
                searchBar.Parent = searchContainer
                searchBar.BackgroundTransparency = 1
                searchBar.Position = UDim2.new(0, 26, 0, 0)
                searchBar.Size = UDim2.new(1, -30, 1, 0)
                searchBar.Font = Theme.Fonts.Body
                searchBar.PlaceholderText = "Search..."
                searchBar.Text = ""
                searchBar.TextColor3 = Theme.Colors.Text
                searchBar.TextSize = 14
                searchBar.TextXAlignment = Enum.TextXAlignment.Left
                searchBar.ZIndex = 22

                local scrollingList = Instance.new("ScrollingFrame")
                scrollingList.Name = "ScrollingList"
                scrollingList.Parent = optionsFrame
                scrollingList.BackgroundTransparency = 1
                scrollingList.Position = UDim2.new(0, 0, 0, 35)
                scrollingList.Size = UDim2.new(1, 0, 1, -35)
                scrollingList.AutomaticCanvasSize = Enum.AutomaticSize.Y
                scrollingList.CanvasSize = UDim2.new(0, 0, 0, 0)
                scrollingList.ScrollBarThickness = 8
                scrollingList.ScrollBarImageTransparency = 0
                scrollingList.ScrollBarImageColor3 = Theme.Colors.Text
                scrollingList.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
                scrollingList.ZIndex = 35

                local listLayout = Instance.new("UIListLayout", scrollingList)
                listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
                local outsideClickListener, positionUpdaterConnection
                local function toggleDropdown(isOpen)
                    if isOpen then
                        local main = dropdown:FindFirstAncestor("main")
                        outsideClickListener = UserInputService.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 and optionsFrame.Visible then
                                local mousePos = input.Position
                                local inOptions = (mousePos.X >= optionsFrame.AbsolutePosition.X and mousePos.X <= optionsFrame.AbsolutePosition.X + optionsFrame.AbsoluteSize.X and mousePos.Y >= optionsFrame.AbsolutePosition.Y and mousePos.Y <= optionsFrame.AbsolutePosition.Y + optionsFrame.AbsoluteSize.Y)
                                local inButton = (mousePos.X >= dropdownButton.AbsolutePosition.X and mousePos.X <= dropdownButton.AbsolutePosition.X + dropdownButton.AbsoluteSize.X and mousePos.Y >= dropdownButton.AbsolutePosition.Y and mousePos.Y <= dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y)
                                
                                local clickedOutside = not inOptions and not inButton
                                
                                if clickedOutside then toggleDropdown(false) end
                            end
                        end)
    
                        optionsFrame.ZIndex = 22
                        optionsFrame.Parent = scrgui 
                        optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
     
                        optionsFrame.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)
                        optionsFrame.Visible = true
                        TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 160)}):Play()
                        TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
    
                        if main then
                            positionUpdaterConnection = main:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                                if optionsFrame.Visible then
                                    optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
                                end
                            end)
                        end
                    else
                        if outsideClickListener then
                            outsideClickListener:Disconnect()
                            outsideClickListener = nil
                        end
                        if positionUpdaterConnection then
                            positionUpdaterConnection:Disconnect()
                            positionUpdaterConnection = nil
                        end
    
                        optionsFrame.ZIndex = 23
                        TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                        local tween = TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)})
                        tween.Completed:Connect(function() 
                            optionsFrame.Visible = false
                            optionsFrame.Parent = dropdown 
                        end)
                        tween:Play()
                    end
                end
    
                local function UpdateOptions(newList)
                    for _, child in pairs(scrollingList:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    for _, optionName in ipairs(newList) do
                    local optionButton = Instance.new("TextButton")
                    optionButton.Name = optionName
                    optionButton.Parent = scrollingList
                    optionButton.BackgroundColor3 = Theme.Colors.ElementBack
                    optionButton.Size = UDim2.new(1, 0, 0, 30)
                    optionButton.BorderSizePixel = 0
                    optionButton.Text = ""
                    optionButton.ZIndex = 9
    
                    local checkmark = Instance.new("Frame", optionButton)
                    checkmark.Name = "Checkmark"
                    checkmark.BackgroundColor3 = Theme.Colors.Primary
                    checkmark.BorderSizePixel = 0
                    checkmark.Size = UDim2.new(0, 8, 0, 8)
                    checkmark.Position = UDim2.new(0, 15, 0.5, -4)
                    checkmark.Visible = false
                    checkmark.ZIndex = 24
                    local uc_check = Instance.new("UICorner", checkmark)
                    uc_check.CornerRadius = UDim.new(1, 0)
                    
                    local textLabel = Instance.new("TextLabel", optionButton)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Theme.Fonts.Body
                    textLabel.Text = optionName
                    textLabel.TextColor3 = Theme.Colors.Text
                    textLabel.TextSize = 14
                    textLabel.TextXAlignment = Enum.TextXAlignment.Left
                    textLabel.ZIndex = 24 
    
                    local padding = Instance.new("UIPadding", textLabel)
                    padding.PaddingLeft = UDim.new(0, 30)
    
                    optionButton.AutoButtonColor = false
    
                    optionButton.MouseButton1Click:Connect(function()
                        if isMultiSelect then
                            selectedItems[optionName] = not selectedItems[optionName]
                            checkmark.Visible = selectedItems[optionName]
    
                            local result = {}
                            for _, item in ipairs(newList) do
                                if selectedItems[item] then table.insert(result, item) end
                            end
    
                            if #result > 0 then
                                dropdownButton.Text = table.concat(result, ", ")
                            else
                                dropdownButton.Text = "Select"
                            end
    
                            if callback then
                                callback(result)
                            end
                        else
                            dropdownButton.Text = optionName
                            toggleDropdown(false)
                            if callback then callback(optionName) end
                        end
                    end)
                    
                    optionButton.MouseEnter:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.Hover end)
                    optionButton.MouseLeave:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.ElementBack end)
                end
                end

                searchBar:GetPropertyChangedSignal("Text"):Connect(function()
                    local text = searchBar.Text:lower()
                    for _, button in ipairs(scrollingList:GetChildren()) do
                        if button:IsA("TextButton") then
                            if button.Name:lower():find(text, 1, true) then
                                button.Visible = true
                            else
                                button.Visible = false
                            end
                        end
                    end
                end)

                UpdateOptions(list)
    
                dropdownButton.MouseButton1Click:Connect(function()
                    toggleDropdown(not optionsFrame.Visible)
                    for _, button in ipairs(scrollingList:GetChildren()) do
                        if button:IsA("TextButton") and button:FindFirstChild("Checkmark") then
                            button.Checkmark.Visible = (isMultiSelect and selectedItems[button.Name]) or (dropdownButton.Text == button.Name)
                        end
                    end
                end)

                local api = {}
                function api:Refresh(newList, keepSelection)
                    if not keepSelection then
                        selectedItems = {}
                        dropdownButton.Text = (isMultiSelect and "Select") or (newList[1] or "Select")
                    end
                    UpdateOptions(newList)
                end
                return api
            end

            return section
        end

        function sec:Header(name)
            layoutOrderCounter = layoutOrderCounter + 1
            local headerFrame = Instance.new("Frame")
            headerFrame.Name = "header"
            headerFrame.Parent = workareamain
            headerFrame.BackgroundTransparency = 1
            headerFrame.Size = UDim2.new(1, 0, 0, 40)
            headerFrame.LayoutOrder = layoutOrderCounter

            local headerLabel = Instance.new("TextLabel")
            headerLabel.Name = "HeaderLabel"
            headerLabel.Parent = headerFrame
            headerLabel.BackgroundTransparency = 1
            headerLabel.Size = UDim2.new(1, 0, 1, 0)
            headerLabel.Position = UDim2.new(0, 0, 0, 0)
            headerLabel.Font = Theme.Fonts.Title
            headerLabel.Text = name
            headerLabel.TextColor3 = Theme.Colors.TextDark
            headerLabel.TextSize = 24
            headerLabel.TextXAlignment = Enum.TextXAlignment.Left
            headerLabel.TextYAlignment = Enum.TextYAlignment.Center
            headerLabel.ZIndex = 2

            layoutOrderCounter = layoutOrderCounter + 1
            local padding = Instance.new("Frame")
            padding.Name = "padding"
            padding.Parent = workareamain
            padding.BackgroundTransparency = 1
            padding.Size = UDim2.new(1, 0, 0, 8)
            padding.LayoutOrder = layoutOrderCounter
        end
        
        function sec:Button(text, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            local button = Instance.new("TextButton")
            button.Name = "button"
            button.Parent = workareamain
            button.BackgroundColor3 = Theme.Colors.LightGray
            button.Size = UDim2.new(1, 0, 0, 37)
            button.BackgroundColor3 = Theme.Colors.ElementBack
            button.Size = UDim2.new(1, 0, 0, 32)
            button.ZIndex = 2
            button.Font = Theme.Fonts.Body
            button.Text = text or "Button"
            button.TextColor3 = Theme.Colors.Text
            button.TextSize = 14
            button.AutoButtonColor = false
            button.LayoutOrder = layoutOrderCounter

            local uc_3 = Instance.new("UICorner")
            uc_3.CornerRadius = Theme.Sizes.SmallRadius
            uc_3.Parent = button

            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.Hover}):Play()
            end)

            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
            end)

            if callback then
                button.MouseButton1Click:Connect(function()
                    TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Colors.Primary}):Play()
                    task.wait(0.1)
                    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Colors.ElementBack}):Play()
                    task.spawn(callback)
                end)
            end
        end

        function sec:Label(name)
            layoutOrderCounter = layoutOrderCounter + 1
            local label = Instance.new("TextLabel")
            label.Name = "label"
            label.Parent = workareamain
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 0, 37)
            label.Font = Theme.Fonts.Body
            label.TextColor3 = Theme.Colors.Text
            label.TextSize = 14
            label.TextWrapped = true
            label.Text = name
            label.LayoutOrder = layoutOrderCounter
            label.TextXAlignment = Enum.TextXAlignment.Left
        end


        function sec:Switch(text, default, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            local toggled = default or false
            
            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Name = "toggleswitch"
            ToggleFrame.Parent = workareamain
            ToggleFrame.BackgroundColor3 = Theme.Colors.ElementBack
            ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
            ToggleFrame.AutoButtonColor = false
            ToggleFrame.Text = ""
            ToggleFrame.LayoutOrder = layoutOrderCounter
            local corner = Instance.new("UICorner", ToggleFrame)
            corner.CornerRadius = Theme.Sizes.SmallRadius

            local ToggleLabel = Instance.new("TextLabel")
            ToggleLabel.Parent = ToggleFrame
            ToggleLabel.BackgroundTransparency = 1
            ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
            ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            ToggleLabel.Font = Theme.Fonts.Body
            ToggleLabel.Text = text or "Switch"
            ToggleLabel.TextColor3 = Theme.Colors.Text
            ToggleLabel.TextSize = 14
            ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ToggleIndicator = Instance.new("Frame")
            ToggleIndicator.Parent = ToggleFrame
            ToggleIndicator.AnchorPoint = Vector2.new(1, 0.5)
            ToggleIndicator.BackgroundColor3 = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
            ToggleIndicator.Position = UDim2.new(1, -10, 0.5, 0)
            ToggleIndicator.Size = UDim2.new(0, 36, 0, 18)
            local indCorner = Instance.new("UICorner", ToggleIndicator)
            indCorner.CornerRadius = UDim.new(1,0)
            local indStroke = Instance.new("UIStroke", ToggleIndicator)
            indStroke.Color = Theme.Colors.Border
            indStroke.Thickness = 1
            indStroke.Parent = ToggleIndicator

            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Parent = ToggleIndicator
            ToggleCircle.BackgroundColor3 = Theme.Colors.Text
            ToggleCircle.Size = UDim2.new(0, 14, 0, 14)
            local circCorner = Instance.new("UICorner", ToggleCircle)
            circCorner.CornerRadius = UDim.new(1,0)

            local offPos = UDim2.new(0, 2, 0.5, 0)
            local onPos = UDim2.new(0, 20, 0, 2)
            ToggleCircle.Position = toggled and onPos or UDim2.new(0, 2, 0, 2)
            ToggleCircle.AnchorPoint = Vector2.new(0, 0)

            ToggleFrame.MouseButton1Click:Connect(function()
                toggled = not toggled
                local targetColor = toggled and Theme.Colors.Primary or Theme.Colors.ContentBack
                local targetPos = toggled and onPos or UDim2.new(0, 2, 0, 2)

                TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
                TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
                if callback then
                    task.spawn(callback, toggled)
                end
            end)
        end


        function sec:TextField(text, placeholder, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            
            local textfield = Instance.new("TextLabel")
            textfield.Name = "textfield"
            textfield.Parent = workareamain
            textfield.BackgroundTransparency = 1
            textfield.Size = UDim2.new(1, 0, 0, 37)
            textfield.Font = Theme.Fonts.Body
            textfield.Text = text
            textfield.TextColor3 = Theme.Colors.Text
            textfield.TextSize = 14
            textfield.TextWrapped = true
            textfield.TextXAlignment = Enum.TextXAlignment.Left
            textfield.LayoutOrder = layoutOrderCounter
            
            local Frame_2 = Instance.new("Frame")
            Frame_2.Parent = textfield
            Frame_2.BackgroundColor3 = Theme.Colors.LightGray
            Frame_2.BackgroundColor3 = Theme.Colors.ElementBack

            Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            Frame_2.AnchorPoint = Vector2.new(0, 0.5)
            Frame_2.Size = UDim2.new(0.5, 0, 1, -6)

            local uc_6 = Instance.new("UICorner")
            uc_6.CornerRadius = Theme.Sizes.SmallRadius
            uc_6.Parent = Frame_2

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = Frame_2
            TextBox.BackgroundTransparency = 1
            TextBox.BorderSizePixel = 0
            TextBox.ClipsDescendants = true
            TextBox.Position = UDim2.new(0, 10, 0, 0)
            TextBox.Size = UDim2.new(1, -20, 1, 0)
            TextBox.ClearTextOnFocus = false
            TextBox.Font = Theme.Fonts.Body
            TextBox.PlaceholderColor3 = Theme.Colors.TextDark
            TextBox.PlaceholderText = placeholder or "Type here..."
            TextBox.Text = ""
            TextBox.TextColor3 = Theme.Colors.Text
            TextBox.TextSize = 14
            TextBox.TextXAlignment = Enum.TextXAlignment.Left

            if callback then
                TextBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        callback(TextBox.Text)
                    end
                end)
            end
        end


        function sec:Slider(text, min, max, default, callback)
            layoutOrderCounter = layoutOrderCounter + 1
            
            local sliderContainer = Instance.new("TextLabel")
            sliderContainer.Name = "slider"
            sliderContainer.Parent = workareamain
            sliderContainer.BackgroundTransparency = 1
            sliderContainer.Size = UDim2.new(1, 0, 0, 50)
            sliderContainer.Font = Theme.Fonts.Body
            sliderContainer.Text = text or "Slider"
            sliderContainer.TextColor3 = Theme.Colors.Text
            sliderContainer.TextSize = 14
            sliderContainer.TextWrapped = true
            sliderContainer.TextXAlignment = Enum.TextXAlignment.Left
            sliderContainer.LayoutOrder = layoutOrderCounter

            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "ValueLabel"
            valueLabel.Parent = sliderContainer
            valueLabel.BackgroundTransparency = 1
            valueLabel.Font = Theme.Fonts.Body
            valueLabel.TextColor3 = Theme.Colors.Text
            valueLabel.TextSize = 14
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right

            valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
            valueLabel.AnchorPoint = Vector2.new(0, 0)
            valueLabel.Size = UDim2.new(0.5, 0, 0, 20)

            local track = Instance.new("Frame")
            track.Name = "Track"
            track.Parent = sliderContainer
            track.BackgroundColor3 = Theme.Colors.LightGray
            track.BackgroundColor3 = Theme.Colors.ElementBack

            track.Position = UDim2.new(0.5, 0, 0.6, 0)
            track.AnchorPoint = Vector2.new(0, 0)
            track.Size = UDim2.new(0.5, 0, 0, 6)
            local trackCorner = Instance.new("UICorner", track)
            trackCorner.CornerRadius = Theme.Sizes.FullRadius

            local fill = Instance.new("Frame")
            fill.Name = "Fill"
            fill.Parent = track
            fill.BackgroundColor3 = Theme.Colors.Primary
            fill.Size = UDim2.new(0, 0, 1, 0)
            local fillCorner = Instance.new("UICorner", fill)
            fillCorner.CornerRadius = Theme.Sizes.FullRadius
            

            createGradient(fill, Theme.Colors.Primary, Theme.Colors.PrimaryLight)

            local thumb = Instance.new("TextButton")
            thumb.Name = "Thumb"
            thumb.Parent = track
            thumb.BackgroundColor3 = Theme.Colors.TextLight
            thumb.Size = UDim2.new(0, 16, 0, 16)
            thumb.AnchorPoint = Vector2.new(0.5, 0.5)
            thumb.Position = UDim2.new(0, 0, 0.5, 0)
            thumb.ZIndex = 3
            thumb.Text = ""
            local thumbCorner = Instance.new("UICorner", thumb)
            thumbCorner.CornerRadius = Theme.Sizes.FullRadius
            local thumbStroke = Instance.new("UIStroke", thumb)
            thumbStroke.Color = Theme.Colors.Gray
            thumbStroke.Thickness = 1

            local currentValue = default or (min or 0)

            local function updateSlider(value, runCallback)
                local v_min = min or 0
                local v_max = max or 100
                currentValue = math.clamp(value, v_min, v_max)
                local percentage = (currentValue - v_min) / (v_max - v_min)
                
                valueLabel.Text = tostring(math.floor(currentValue * 100) / 100) 
                
                local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(fill, tweenInfo, {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                TweenService:Create(thumb, tweenInfo, {Position = UDim2.new(percentage, 0, 0.5, 0)}):Play()

                if runCallback and callback then
                    task.spawn(callback, currentValue)
                end
            end

            thumb.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    local moveConn, releaseConn
                    moveConn = UserInputService.InputChanged:Connect(function(moveInput)
                        local v_min = min or 0
                        local v_max = max or 100
                        local percentage = (moveInput.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
                        local newValue = v_min + (v_max - v_min) * math.clamp(percentage, 0, 1)
                        updateSlider(newValue, true)
                    end)
                    releaseConn = UserInputService.InputEnded:Connect(function()
                        moveConn:Disconnect()
                        releaseConn:Disconnect()
                    end)
                end
            end)

            updateSlider(currentValue, false)
        end

        function sec:Dropdown(name, list, multi, p4, p5)
            local defaultValue, callback
            if type(p4) == 'function' and p5 == nil then
                defaultValue = nil
                callback = p4
            else
                defaultValue = p4
                callback = p5
            end

            layoutOrderCounter = layoutOrderCounter + 1
            local dropdown = Instance.new("TextLabel")
            dropdown.Name = "dropdown"
            dropdown.Parent = workareamain
            dropdown.BackgroundTransparency = 1
            dropdown.Size = UDim2.new(1, 0, 0, 37)
            dropdown.Font = Theme.Fonts.Body
            dropdown.Text = name
            dropdown.TextColor3 = Theme.Colors.Text
            dropdown.TextSize = 14
            dropdown.TextXAlignment = Enum.TextXAlignment.Left
            dropdown.LayoutOrder = layoutOrderCounter

            local selectedItems = {}
            local isMultiSelect = multi or false

            if isMultiSelect and type(defaultValue) == "table" then
                for _, v in pairs(defaultValue) do
                    selectedItems[v] = true
                end
            end

            local dropdownButton = Instance.new("TextButton")
            dropdownButton.Name = "DropdownButton"
            dropdownButton.Parent = dropdown
            dropdownButton.BackgroundColor3 = Theme.Colors.LightGray
            dropdownButton.Parent = dropdown            
            dropdownButton.BackgroundColor3 = Theme.Colors.ElementBack
            dropdownButton.Position = UDim2.new(0.5, 0, 0.5, 0)
            dropdownButton.AnchorPoint = Vector2.new(0, 0.5)
            dropdownButton.Size = UDim2.new(0.5, 0, 1, -6)
            dropdownButton.Font = Theme.Fonts.Body
            dropdownButton.Text = (isMultiSelect and "Select") or (defaultValue or list[1] or "Select")
            if isMultiSelect and type(defaultValue) == "table" and #defaultValue > 0 then
                dropdownButton.Text = table.concat(defaultValue, ", ")
            else
                dropdownButton.Text = (not isMultiSelect and (defaultValue or list[1])) or "Select"
            end
            dropdownButton.TextColor3 = Theme.Colors.Text
            dropdownButton.TextSize = 14
            dropdownButton.ZIndex = 8
            dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
            dropdownButton.TextTruncate = Enum.TextTruncate.AtEnd

            local textPadding = Instance.new("UIPadding", dropdownButton)
            textPadding.PaddingLeft = UDim.new(0, 10)
            textPadding.PaddingRight = UDim.new(0, 25)
            
            local uc_drop = Instance.new("UICorner", dropdownButton)
            uc_drop.CornerRadius = Theme.Sizes.SmallRadius

            local arrow = Instance.new("ImageLabel", dropdownButton)
            arrow.BackgroundTransparency = 1
            arrow.AnchorPoint = Vector2.new(0.5, 0.5)
            arrow.Position = UDim2.new(1, -15, 0.5, 0)
            arrow.Size = UDim2.new(0, 12, 0, 12)
            arrow.Image = "rbxassetid://3926305904"
            arrow.ImageColor3 = Theme.Colors.Text

            local optionsFrame = Instance.new("Frame")

            optionsFrame.Name = "OptionsFrame"
            optionsFrame.Parent = dropdown
            optionsFrame.BackgroundColor3 = Theme.Colors.SectionBack
            optionsFrame.BorderSizePixel = 0

            optionsFrame.Position = UDim2.new(0.5, 0, 1, 5) 
            optionsFrame.AnchorPoint = Vector2.new(0, 0)
            optionsFrame.Size = UDim2.new(0.5, 0, 0, 0) 
            optionsFrame.Visible = false
            optionsFrame.ZIndex = 20
            optionsFrame.ClipsDescendants = true
            

            local uc_options = Instance.new("UICorner", optionsFrame)
            uc_options.CornerRadius = Theme.Sizes.SmallRadius

            local searchContainer = Instance.new("Frame")
            searchContainer.Name = "SearchContainer"
            searchContainer.Parent = optionsFrame
            searchContainer.BackgroundColor3 = Theme.Colors.ElementBack
            searchContainer.Position = UDim2.new(0, 5, 0, 5)
            searchContainer.Size = UDim2.new(1, -10, 0, 25)
            searchContainer.ZIndex = 21
            local uc_search = Instance.new("UICorner", searchContainer)
            uc_search.CornerRadius = Theme.Sizes.SmallRadius

            local searchIcon = Instance.new("ImageLabel")
            searchIcon.Name = "SearchIcon"
            searchIcon.Parent = searchContainer
            searchIcon.BackgroundTransparency = 1
            searchIcon.Size = UDim2.new(0, 14, 0, 14)
            searchIcon.Position = UDim2.new(0, 6, 0.5, 0)
            searchIcon.AnchorPoint = Vector2.new(0, 0.5)
            searchIcon.Image = "rbxassetid://5036466001"
            searchIcon.ImageColor3 = Theme.Colors.Text
            searchIcon.ZIndex = 22

            local searchBar = Instance.new("TextBox")
            searchBar.Name = "SearchBar"
            searchBar.Parent = searchContainer
            searchBar.BackgroundTransparency = 1
            searchBar.Position = UDim2.new(0, 26, 0, 0)
            searchBar.Size = UDim2.new(1, -30, 1, 0)
            searchBar.Font = Theme.Fonts.Body
            searchBar.PlaceholderText = "Search..."
            searchBar.Text = ""
            searchBar.TextColor3 = Theme.Colors.Text
            searchBar.TextSize = 14
            searchBar.TextXAlignment = Enum.TextXAlignment.Left
            searchBar.ZIndex = 22

            local scrollingList = Instance.new("ScrollingFrame")
            scrollingList.Name = "ScrollingList"
            scrollingList.Parent = optionsFrame
            scrollingList.BackgroundTransparency = 1
            scrollingList.Position = UDim2.new(0, 0, 0, 35)
            scrollingList.Size = UDim2.new(1, 0, 1, -35)
            scrollingList.AutomaticCanvasSize = Enum.AutomaticSize.Y
            scrollingList.CanvasSize = UDim2.new(0, 0, 0, 0)
            scrollingList.ScrollBarThickness = 8
            scrollingList.ScrollBarImageTransparency = 0
            scrollingList.ScrollBarImageColor3 = Theme.Colors.Text
            scrollingList.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
            scrollingList.ZIndex = 35

            local listLayout = Instance.new("UIListLayout", scrollingList)
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local outsideClickListener, positionUpdaterConnection
            local function toggleDropdown(isOpen)
                if isOpen then
                    local main = dropdown:FindFirstAncestor("main")
                    outsideClickListener = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 and optionsFrame.Visible then
                            local mousePos = input.Position
                            local inOptions = (mousePos.X >= optionsFrame.AbsolutePosition.X and mousePos.X <= optionsFrame.AbsolutePosition.X + optionsFrame.AbsoluteSize.X and mousePos.Y >= optionsFrame.AbsolutePosition.Y and mousePos.Y <= optionsFrame.AbsolutePosition.Y + optionsFrame.AbsoluteSize.Y)
                            local inButton = (mousePos.X >= dropdownButton.AbsolutePosition.X and mousePos.X <= dropdownButton.AbsolutePosition.X + dropdownButton.AbsoluteSize.X and mousePos.Y >= dropdownButton.AbsolutePosition.Y and mousePos.Y <= dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y)
                            
                            local clickedOutside = not inOptions and not inButton
                            
                            if clickedOutside then toggleDropdown(false) end
                        end
                    end)

                    optionsFrame.ZIndex = 22
                    optionsFrame.Parent = scrgui 
                    optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
 
                    optionsFrame.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)
                    optionsFrame.Visible = true
                    TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 160)}):Play()
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 180}):Play()

                    if main then
                        positionUpdaterConnection = main:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                            if optionsFrame.Visible then
                                optionsFrame.Position = UDim2.new(0, dropdownButton.AbsolutePosition.X, 0, dropdownButton.AbsolutePosition.Y + dropdownButton.AbsoluteSize.Y + 5)
                            end
                        end)
                    end
                else
                    if outsideClickListener then
                        outsideClickListener:Disconnect()
                        outsideClickListener = nil
                    end
                    if positionUpdaterConnection then
                        positionUpdaterConnection:Disconnect()
                        positionUpdaterConnection = nil
                    end

                    optionsFrame.ZIndex = 23
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    local tween = TweenService:Create(optionsFrame, TweenInfo.new(0.2), {Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)})
                    tween.Completed:Connect(function() 
                        optionsFrame.Visible = false
                        optionsFrame.Parent = dropdown 
                        if optionsFrame.Parent then
                            optionsFrame.Visible = false
                            optionsFrame.Parent = dropdown 
                        end
                    end)
                    tween:Play()
                end
            end

            local function UpdateOptions(newList)
                for _, child in pairs(scrollingList:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                for _, optionName in ipairs(newList) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = optionName
                optionButton.Parent = scrollingList
                optionButton.BackgroundColor3 = Theme.Colors.ElementBack
                optionButton.Size = UDim2.new(1, 0, 0, 30)
                optionButton.BorderSizePixel = 0
                optionButton.Text = ""
                optionButton.ZIndex = 36

                local checkmark = Instance.new("Frame", optionButton)
                checkmark.Name = "Checkmark"
                checkmark.BackgroundColor3 = Theme.Colors.Primary
                checkmark.BorderSizePixel = 0
                checkmark.Size = UDim2.new(0, 8, 0, 8)
                checkmark.Position = UDim2.new(0, 15, 0.5, -4)
                checkmark.Visible = false
                checkmark.ZIndex = 24
                local uc_check = Instance.new("UICorner", checkmark)
                uc_check.CornerRadius = UDim.new(1, 0)
                
                local textLabel = Instance.new("TextLabel", optionButton)
                textLabel.BackgroundTransparency = 1
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Font = Theme.Fonts.Body
                textLabel.Text = optionName
                textLabel.TextColor3 = Theme.Colors.Text
                textLabel.TextSize = 14
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.ZIndex = 24 

                local padding = Instance.new("UIPadding", textLabel)
                padding.PaddingLeft = UDim.new(0, 30)

                optionButton.AutoButtonColor = false

                optionButton.MouseButton1Click:Connect(function()
                    if isMultiSelect then
                        selectedItems[optionName] = not selectedItems[optionName]
                        checkmark.Visible = selectedItems[optionName]

                        local result = {}
                        for _, item in ipairs(newList) do
                            if selectedItems[item] then table.insert(result, item) end
                        end

                        if #result > 0 then
                            dropdownButton.Text = table.concat(result, ", ")
                        else
                            dropdownButton.Text = "Select"
                        end

                        if callback then
                            callback(result)
                        end
                    else
                        dropdownButton.Text = optionName
                        toggleDropdown(false)
                        if callback then callback(optionName) end
                    end
                end)
                
                optionButton.MouseEnter:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.Hover end)
                optionButton.MouseLeave:Connect(function() optionButton.BackgroundColor3 = Theme.Colors.ElementBack end)
            end
            end

            searchBar:GetPropertyChangedSignal("Text"):Connect(function()
                local text = searchBar.Text:lower()
                for _, button in ipairs(scrollingList:GetChildren()) do
                    if button:IsA("TextButton") then
                        if button.Name:lower():find(text, 1, true) then
                            button.Visible = true
                        else
                            button.Visible = false
                        end
                    end
                end
            end)

            UpdateOptions(list)

            dropdownButton.MouseButton1Click:Connect(function()
                toggleDropdown(not optionsFrame.Visible)
                for _, button in ipairs(scrollingList:GetChildren()) do
                    if button:IsA("TextButton") and button:FindFirstChild("Checkmark") then
                        button.Checkmark.Visible = (isMultiSelect and selectedItems[button.Name]) or (dropdownButton.Text == button.Name)
                    end
                end
            end)

            local api = {}
            function api:Refresh(newList, keepSelection)
                if not keepSelection then
                    selectedItems = {}
                    dropdownButton.Text = (isMultiSelect and "Select") or (newList[1] or "Select")
                end
                UpdateOptions(newList)
            end
            return api
        end

        sidebar2.MouseButton1Click:Connect(function()
            sec:Select()
        end)

        return sec
    end

    return window
end

return lib
