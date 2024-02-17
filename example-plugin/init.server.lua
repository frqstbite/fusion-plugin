local packages = script.Packages

local Fusion = require(packages.Fusion)
local Children = Fusion.Children
local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Out = Fusion.Out
local Value = Fusion.Value

local FusionPlugin = require(packages.FusionPlugin)(Fusion, plugin)
local DockWidget = FusionPlugin.DockWidget
local Toolbar = FusionPlugin.Toolbar
local ToolbarButton = FusionPlugin.ToolbarButton

local image = "rbxassetid://7120897383"
local open = Value(false)

Toolbar "Example Plugin" {
    ToolbarButton "settings" {
        Active = open,
        ClickableWhenViewportHidden = true,
        [OnEvent "Click"] = function()
            open:set(not open:get())
        end,

        -- NON-REACTIVE
        Text = "Settings",
        Tooltip = "Open example plugin's settings",
        Icon = image,
    },
}

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