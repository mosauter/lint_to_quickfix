local M = {}

---@class LineEntry
---@field filename string
---@field lnum string
---@field col string
---@field text string

---@param tbl string[]
---@param idx number
---@param sep string
---@return string
local function concatenate(tbl, idx, sep)
    local result = nil

    for index, value in ipairs(tbl) do
        if index >= idx then
            if result == nil then
                result = value
            else
                result = result .. sep .. value
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
    print(line)

    if has_col == nil or has_col == true then
        print("cols")
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
