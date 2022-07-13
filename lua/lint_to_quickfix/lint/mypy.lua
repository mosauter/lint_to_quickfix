local M = {}

local utils = require("lint_to_quickfix._utils")

---@param file_path string file to check
---@return LineEntry[] entries result entries
function M.lint(file_path)
    local entries = {}

    if not utils.is_executable("mypy") then
        return entries
    end

    local report = io.popen(
        "mypy "
            .. "--no-pretty "
            .. "--no-error-summary "
            .. "--show-column-numbers "
            .. file_path
    )

    if report == nil then
        return entries
    end

    local line = report:read()
    while line ~= nil do
        table.insert(entries, utils.line_to_entry(line, ":"))

        line = report:read()
    end

    return entries
end

return M
