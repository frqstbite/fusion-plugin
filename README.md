# fusion-plugin #

![GitHub License](https://img.shields.io/github/license/frqstbite/fusion-plugin)
![Discord](https://img.shields.io/discord/385151591524597761?label=need%20help%3F&logo=discord&logoColor=%2300BE9B&color=%2300BE9B&link=https%3A%2F%2Fdiscord.gg%2Fr4qaSqKMqq)

Build powerful plugins for Roblox Studio with [Fusion](https://elttob.uk/Fusion), a modern reactivity library for [Roblox](https://developer.roblox.com) [Luau](https://luau-lang.org).

### Table of Contents ###

* [Installation](#installation)
* [Usage](#usage)
  * [Dockable Widgets](#dockable-widgets)
  * [Toolbars](#toolbars)
  * [Plugin Menus](#plugin-menus)
  * [Plugin Actions](#plugin-actions)
* [Contribution](#contribution)
* [License](#license)

## Installation ##

`fusion-plugin` is available on the [wally](https://wally.run) package manager. Copy the install string from the [project page](https://wally.run/package/frqstbite/fusion-plugin) and paste it into your `wally.toml`. Then, run `wally install`.

## Usage ##

Everything you'll need is available in the module.
You acquire it like so, filling in the proper paths:

```lua
local Fusion = require(...)
-- .Value, .Computed, .New

local FusionPlugin = require(...)(Fusion, plugin)
-- .DockWidget, .Toolbar, .ToolbarButton
```

You must call the required result, passing in your Fusion and plugin context. This is necessary because automatic dependency capturing only works on reactive objects from the same Fusion instance.<sup>[*citation needed*]</sup>

### Dockable Widgets ###

Dockable widgets are exposed through a function called DockWidget. Here's an example of what a settings panel might look like:
```lua
local DockWidget = FusionPlugin.DockWidget

local open = Value(false) --whether the dockable is open or not

DockWidget "examplePluginSettings" {
    Title = "Example Plugin Settings",
    Enabled = open,
    [Out "Enabled"] = open,
    [Children] = ... --mount panel root component

    -- NON-REACTIVE
    Size = Vector2.new(400, 300),
    MinimumSize = Vector2.new(100, 100), --Defaults to .Size
}
```
Note how some props are **not reactive** due to the immutability of [DockWidgetPluginGuiInfo](https://create.roblox.com/docs/reference/engine/datatypes/DockWidgetPluginGuiInfo).

### Toolbars

Toolbars can be elegantly expressed with two functions, as so:

```lua
local Toolbar = FusionPlugin.Toolbar
local ToolbarButton = FusionPlugin.ToolbarButton

Toolbar "Example Plugin" {
    ToolbarButton {
        Active = ..., --whether the button is shaded gray
        ClickableWhenViewportHidden = true,
        [OnEvent "Click"] = function()
            print("TODO: open example plugin settings widget")
        end

        -- NON-REACTIVE
        Text = "Settings",
        Tooltip = "Open example plugin's settings",
        Icon = "rbxassetid://4458900760",
    }
}
```

Note how some props are **not reactive** due to the immutability of [PluginToolbar:CreateButton()](https://create.roblox.com/docs/reference/engine/classes/PluginToolbar#CreateButton)'s arguments.

### Plugin Menus ###

### Plugin Actions ###

## Contribution ##
File an issue if you encounter a bug. Pull requests for bugfixes and improvements are welcome.


## License ##
This library is licensed under the [MIT License](https://choosealicense.com/licenses/mit).
