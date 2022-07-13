---@alias Linter
---| 'pylint' # lint with pylint
---| 'mypy' # lint with pylint

---@alias Mode
---| 'a' # found items are added to qflist
---| 'r' # found items replace qflist

---@param linter Linter
---@return fun(file_path: string, mode: Mode)
local function curry(linter)
    return function(file_path, mode)
        require("lint_to_quickfix.main").lint_to_qf(file_path, mode, linter)
    end
end

return {
    pylint = curry("pylint"),
    mypy = curry("mypy"),
}
