local ToolbarButton = require(script.Parent.ToolbarButton)
type ToolbarButtonConstructor = ToolbarButton.ToolbarButtonConstructor

return function(_: any, plugin: Plugin)
    local function Toolbar(name: string)
        local toolbar = plugin:CreateToolbar(name)
        return function(buttons: {ToolbarButtonConstructor})
            for _, constructor in ipairs(buttons) do
                constructor(toolbar)
            end
        end
    end

    return Toolbar
end