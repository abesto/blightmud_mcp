# Blightmud MCP

This is a plugin for [Blightmud](https://github.com/Blightmud/Blightmud.git) that implements the [MUD Client Protocol v2.1](http://www.moo.mud.org/mcp2/mcp2.html).

## Supported Packages
| Package                   | Description                                                                                           |
| --------------------------|-------------------------------------------------------------------------------------------------------|
|dns-com-vmoo-client        | Report client name and version to the MOO. Also sets @linelength based on terminal width.             |
|dns-org-mud-moo-simpleedit | Allow editing of MOO verbs and lists in an external editor.                                           |
|dns-com-awns-status        | Write arbitrary text to the client status bar.                                                        |

In addition, for MOOs that don't support MCP, these scripts include support for the [early LambdaMOO local editing protocol](https://lisdude.com/moo/localEditing.moo).

## Installation
Within Blightmud:
1. `/add plugin https://github.com/lisdude/blightmud_mcp`
2. `/enable_plugin blightmud_mcp`

## Commands
Some packages add custom commands:
| Command  | Effect                                                                                                 |
| ---------|--------------------------------------------------------------------------------------------------------|
| /linelen | Set your @linelength based on your terminal width.                                                     |
| /flush   | Reset the local editor. This deletes all intermediary .moo files and stops monitoring them for changes.|

## Configuration
You can customize some settings inside the `main.lua` file. You can find the file in `/home/<your username>/.local/share/blightmud/plugins/blightmud_mcp` or type `/help plugin` in Blightmud to get the plugin path.
| Setting                  | Effect                                                                                                                             |
| -------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| simpleedit_path          | The path where editor files are created.                                                                                           |
| simpleedit_timeout       | The amount of time, in seconds, to wait after editing a file before it's considered abandoned and deleted. 0 disables the timeout. |
| edit_command             | The command executed to launch your editor.                                                                                        |
| stat_command             | Your 'stat' command. macOS users should use the Homebrew `gstat` command.                                                          |
| lambdamoo_connect_string | The string used to identify a MOO and initialize the LambdaMOO local edit protocol. (Only applies to MOOs without MCP 2.1.)        |
| debug_mcp                | Don't hide out-of-band MCP communication. Show additional debugging messages.                                                      |
