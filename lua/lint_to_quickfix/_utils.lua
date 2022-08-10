local M = {}

---@class LineEntry
---@field filename string
---@field lnum string
---@field col string
---@field text string

---@param tbl string[] an array of strings
---@param idx number index from which to combine all to the end
---@param sep? string to add between each string from {tbl}
---@return string the string from `idx`
local function concatenate(tbl, idx, sep)
    local result = nil

    for index, value in ipairs(tbl) do
        if index >= idx then
            if result == nil then
                result = value
            else
                result = result .. (sep or "") .. value
            end
        end
    end

    return result
end

---@param line string
---@param sep? string
---@param has_col? boolean
---@return LineEntry
function M.line_to_entry(line, sep, has_col)
    local splits = vim.split(line, sep or "|")

    if has_col == nil or has_col == true then
        return {
            filename = splits[1],
            lnum = splits[2],
            col = splits[3],
            text = concatenate(splits, 4, sep or "|"),
        }
    end

    return {
        filename = splits[1],
        lnum = splits[2],
        text = concatenate(splits, 3, sep or "|"),
    }
end

---@param program string
---@return boolean
function M.is_executable(program)
    if vim.fn.executable(program) == 0 then
        print("'" .. program .. "' is not on $PATH, aborting...")
        return false
    end

    return true
end

return M
