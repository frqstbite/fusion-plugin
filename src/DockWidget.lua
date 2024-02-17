local root = script.Parent

return function(fusion, plugin)
    local Hydrate = fusion.Hydrate
    local unwrap = require(root.unwrap)

    type DockWidgetProps = {
        
    }

    local function DockWidget(id: string)
        return function(props: {[string]: any})

            props = props or {}
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
end