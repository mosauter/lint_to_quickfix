---@mod lint_to_quickfix
---@brief [[
---This plugin gives you the possiblity to easily run a linter
---and get the results into your quickfix list.
---
---Currently it supports mainly some linters for python and bash/sh
---but new ones can be added quite easily.
--=@brief ]]

---@alias LintToQfLinter
---| 'pylint' # lint with pylint
---| 'mypy' # lint with mypy
---| 'shellcheck' # lint with shellcheck

---@alias LintToQfMode
---| 'a' # found items are added to qflist
---| 'r' # found items replace qflist

---@alias CurriedLinterFunction fun(file_path?: string, mode?: LintToQfMode) The linter functions curried with sensible defaults.

---@param linter LintToQfLinter
---@param file_types string[]
---@return CurriedLinterFunction
local function curry(linter, file_types)
    return function(file_path, mode)
        require("lint_to_quickfix.main").lint_to_qf(
            linter,
            file_types,
            file_path,
            mode
        )
    end
end

---@class LinterToQf
---@field pylint CurriedLinterFunction
---@field mypy CurriedLinterFunction
---@field shellcheck CurriedLinterFunction

---@export LinterToQf
return {
    pylint = curry("pylint", { "python" }),
    mypy = curry("mypy", { "python" }),
    shellcheck = curry("shellcheck", { "sh", "zsh", "bash" }),
    lint = require("lint_to_quickfix.main").lint_to_qf,
}
