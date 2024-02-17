local root = script.Parent.Parent
local Fusion = require(root.Packages.Fusion)
local Hydrate = Fusion.Hydrate
local unwrap = require(root.unwrap)

type DockWidgetProps = {
    
}

local function DockWidget(id: string)
    return function(props: {[string]: any})

        props = props or {}
        local plugin = unwrap(props.Plugin) :: Plugin
        local size = unwrap(props.Size) :: Vector2
        local minimumSize = unwrap(props.MinimumSize) :: Vector2?
        
        -- Create widget
        local widget = plugin:CreateDockWidgetPluginGui(id, DockWidgetPluginGuiInfo.new(
            Enum.InitialDockState.Float,
            false,
            false,
            size.X,
            size.Y,
            if minimumSize then minimumSize.X else size.X,
            if minimumSize then minimumSize.Y else size.Y
        ))
        
        props.Name = id
        props.Size = nil
        props.MinimumSize = nil
        return Hydrate(widget)(props)
    end
end

return DockWidget