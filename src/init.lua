type Fusion = typeof(require(script.Fusion))

return function(fusion: Fusion, plugin: Plugin)
    return {
        DockWidget = require(script.DockWidget)(fusion, plugin),
        Toolbar = require(script.Toolbar)(fusion, plugin),
        ToolbarButton = require(script.ToolbarButton)(fusion, plugin),
    }
end