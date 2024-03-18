local packages = script.Packages

local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Value = Fusion.Value

local FusionPlugin = require(packages.FusionPlugin)(Fusion, plugin)
local DockWidget = FusionPlugin.DockWidget
local Action = FusionPlugin.Action
local Toolbar = FusionPlugin.Toolbar
local ToolbarButton = FusionPlugin.ToolbarButton

local image = "rbxassetid://7120897383"
local open = Value(false) --whetyher the settings widget is open

-- Plugin menu
-- Nothing special here yet :(
local coolmenu = plugin:CreatePluginMenu("coolmenu", "Cool Menu", "")
coolmenu:AddAction(Action "coolaction" {
    Bindable = true,
    Icon = image,
    Text = "Cool Action",
    Tooltip = "this means only good things",

    [OnEvent "Triggered"] = function()
        print("cool things underway.......")
    end,
})

-- Set up toolbar
Toolbar "Example Plugin" {
    -- Cool button
    ToolbarButton "cool menu" {
        Active = false,
        [OnEvent "Click"] = function()
            local r = coolmenu:ShowAsync()
            print(r and r.Name)
        end,
        
        ClickableWhenViewportHidden = true,
        Text = "Cool",
        Tooltip = "Open example plugin's cool menu",
        Icon = image,
    },

    -- Settings button
    ToolbarButton "settings" {
        Active = open,
        [OnEvent "Click"] = function()
            open:set(not open:get())
        end,
        
        ClickableWhenViewportHidden = true,
        Text = "Settings",
        Tooltip = "Open example plugin's settings",
        Icon = image,
    },
}

-- Settings widget
DockWidget ("examplePluginSettings") {
    Title = "Example Plugin Settings",
    Enabled = open,
    [Out "Enabled"] = open,
    [Children] = New "ImageLabel" {
        Image = image,
        Size = UDim2.fromScale(1, 1),
    },

    -- NON-REACTIVE
    Size = Vector2.new(400, 300),
    MinimumSize = Vector2.new(100, 100), --Defaults to .Size
}