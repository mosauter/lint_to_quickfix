---@alias LintToQfLinter
---| 'pylint' # lint with pylint
---| 'mypy' # lint with pylint

---@alias LintToQfMode
---| 'a' # found items are added to qflist
---| 'r' # found items replace qflist

---@param linter LintToQfLinter
---@return fun(file_path?: string, mode?: LintToQfMode)
local function curry(linter)
    return function(file_path, mode)
        require("lint_to_quickfix.main").lint_to_qf(linter, file_path, mode)
    end
end

return {
    pylint = curry("pylint"),
    mypy = curry("mypy"),
}
