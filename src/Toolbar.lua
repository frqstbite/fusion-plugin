type Fusion = typeof(require(script.Parent.Fusion))

return function(_, plugin: Plugin)
    local function Toolbar(name: string)
        local toolbar = plugin:CreateToolbar(name)
        return function(buttons)
            for _, constructor in ipairs(buttons) do
                constructor(toolbar)
            end
        end
    end

    return Toolbar
end