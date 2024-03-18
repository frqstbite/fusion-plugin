local root = script.Parent
local unwrap = require(root.unwrap)

local fusionTypes = require(root.FusionTypes)
type CanBeState<T> = fusionTypes.CanBeState<T>

export type ToolbarButtonProps = {
    Active: CanBeState<boolean>,
    Icon: string,
    Text: string,
    Tooltip: string,
}

export type ToolbarButtonConstructor = (toolbar: PluginToolbar) -> PluginToolbarButton

return function(fusion: any, plugin: Plugin)
    local Cleanup = fusion.Cleanup
    local Hydrate = fusion.Hydrate
    local Observer = fusion.Observer

    local function ToolbarButton(id: string)
        return function(props: ToolbarButtonProps)
            props = props or {}
            
            return function(toolbar: PluginToolbar)
                local button = toolbar:CreateButton(id, unwrap(props.Tooltip), unwrap(props.Icon), unwrap(props.Text))
                
                local active = props.Active
                if unwrap(active) ~= active then
                    -- If it's a reactive value, we'll need to update the button's active state
                    -- Make sure this connection is cleaned up
                    props[Cleanup] = {
                        Observer(active):onChange(function()
                            button:SetActive(active:get() or false)
                        end)
                    }
                end

                props.Tooltip = nil
                props.Text = nil
                props.Active = nil
                return Hydrate(button)(props)
            end
        end
    end

    return ToolbarButton
end