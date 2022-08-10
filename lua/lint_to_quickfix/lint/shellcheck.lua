local M = {}

local utils = require("lint_to_quickfix._utils")
local executable = "shellcheck"

---@param file_path string file to check
---@return LineEntry[] entries result entries
function M.lint(file_path)
    local entries = {}

    if not utils.is_executable(executable) then
        return entries
    end

    local shellcheck_report =
        io.popen(executable .. " --format=gcc " .. file_path)

    if shellcheck_report == nil then
        return entries
    end

    local line = shellcheck_report:read()
    while line ~= nil do
        table.insert(entries, utils.line_to_entry(line, ":"))

        line = shellcheck_report:read()
    end
    return entries
end

return M
