local M = {}

local utils = require("lint_to_quickfix._utils")

---@param file_path string file to check
---@return LineEntry[] entries result entries
---@return boolean got_results if any results are found
function M.lint(file_path)
    local entries = {}
    local got_results = false

    if not utils.is_executable("mypy") then
        return entries, got_results
    end

    local report = io.popen(
        "mypy "
            .. "--no-pretty "
            .. "--no-error-summary "
            .. "--show-column-numbers "
            .. file_path
    )

    if report == nil then
        return entries, got_results
    end

    local line = report:read()
    while line ~= nil do
        got_results = true
        table.insert(entries, utils.line_to_entry(line, ":"))

        line = report:read()
    end

    return entries, got_results
end

return M
