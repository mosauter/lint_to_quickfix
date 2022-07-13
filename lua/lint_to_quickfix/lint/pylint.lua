local M = {}

local utils = require("lint_to_quickfix._utils")

---@param file_path string file to check
---@return LineEntry[] entries result entries
---@return boolean got_results if any results are found
function M.lint(file_path)
    local entries = {}
    local got_results = false

    if not utils.is_executable("pylint") then
        return entries, got_results
    end

    local pylint_report = io.popen(
        "pylint "
            .. "--msg-template='{path}|{line}|{column}|[{msg_id}: {symbol}] {msg}' "
            .. "--reports=n "
            .. "--score=n "
            .. file_path
    )

    if pylint_report == nil then
        return entries, got_results
    end

    local line = pylint_report:read()
    while line ~= nil do
        -- ignore module separator
        if string.find(line, "%*%*%*%*%*%*%*%*") == nil then
            got_results = true
            table.insert(entries, utils.line_to_entry(line))
        end

        line = pylint_report:read()
    end
    return entries, got_results
end

return M
