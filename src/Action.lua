local root = script.Parent

local fusionTypes = require(root.FusionTypes)
type CanBeState<T> = fusionTypes.CanBeState<T>

export type ActionProps = {
    Bindable: boolean?,
    Icon: string?,
    Text: string,
    Tooltip: string,
}

return function(fusion: any, plugin: Plugin)
    local Hydrate = fusion.Hydrate

    local function Action(id: string)
        return function(props: ActionProps): DockWidgetPluginGui

            props = props or {}
            local bindable = props.Bindable or false
            local icon = props.Icon
            local text = props.Text
            assert(text, "Text prop is required on Actions")
            local tooltip = props.Tooltip
            assert(tooltip, "Tooltip prop is required on Actions")
            
            -- Create action
            local action = plugin:CreatePluginAction(id, text, tooltip, icon, bindable)
            
            props.Bindable = nil
            props.Icon = nil
            props.Name = id
            props.Text = nil
            props.Tooltip = nil

            return Hydrate(action)(props)
        end
    end

    return Action
end