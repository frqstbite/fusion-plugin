local root = script.Parent

local fusionTypes = require(root.FusionTypes)
type CanBeState<T> = fusionTypes.CanBeState<T>

return function(fusion: any, plugin: Plugin)
    local Hydrate = fusion.Hydrate

    type DockWidgetProps = {
        Enabled: CanBeState<boolean>?,
        InitialDockState: Enum.InitialDockState?,
        MinimumSize: Vector2?,
        Size: Vector2,
        Title: CanBeState<string>?,
    }

    local function DockWidget(id: string)
        return function(props: DockWidgetProps): DockWidgetPluginGui

            props = props or {}
            local initialDockState = props.InitialDockState
            local size = props.Size
            local minimumSize = props.MinimumSize or size
            
            -- Create widget
            local widget = plugin:CreateDockWidgetPluginGui(id, DockWidgetPluginGuiInfo.new(
                initialDockState or Enum.InitialDockState.Float,
                false,
                false,
                size.X,
                size.Y,
                if minimumSize then minimumSize.X else size.X,
                if minimumSize then minimumSize.Y else size.Y
            ))
            
            props.Enabled = props.Enabled or false
            props.InitialDockState = nil
            props.Name = id
            props.MinimumSize = nil
            props.Size = nil
            props.Title = props.Title or id
            return Hydrate(widget)(props)
        end
    end

    return DockWidget
end