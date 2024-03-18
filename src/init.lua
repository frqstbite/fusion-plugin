return function(fusion: any, plugin: Plugin)
    return {
        Action = require(script.Action)(fusion, plugin),
        DockWidget = require(script.DockWidget)(fusion, plugin),
        Toolbar = require(script.Toolbar)(fusion, plugin),
        ToolbarButton = require(script.ToolbarButton)(fusion, plugin),
    }
end