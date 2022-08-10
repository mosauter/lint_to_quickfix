---@alias LintToQfLinter
---| 'pylint' # lint with pylint
---| 'mypy' # lint with mypy
---| 'shellcheck' # lint with shellcheck

---@alias LintToQfMode
---| 'a' # found items are added to qflist
---| 'r' # found items replace qflist

---@param linter LintToQfLinter
---@param file_types string[]
---@return fun(file_path?: string, mode?: LintToQfMode)
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

return {
    pylint = curry("pylint", { "python" }),
    mypy = curry("mypy", { "python" }),
    shellcheck = curry("shellcheck", { "sh", "zsh", "bash" }),
}
