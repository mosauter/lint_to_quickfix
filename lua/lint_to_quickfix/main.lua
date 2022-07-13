local M = {}

---@param linter LintToQfLinter
---@param file_path? string file to check
---@param mode? LintToQfMode
function M.lint_to_qf(linter, file_path, mode)
    if mode == nil then
        mode = "r"
    end

    local use_file_path = file_path
    if use_file_path == nil then
        local buffer = vim.api.nvim_get_current_buf()
        use_file_path = vim.api.nvim_buf_get_name(buffer)

        local buffer_filetype = vim.api.nvim_buf_get_option(buffer, "filetype")
        if buffer_filetype ~= "python" then
            print("This function can only work with python-files!")
            return
        end
    else
        print("Scanning '" .. file_path .. "'")
        print("This can take a while...")
    end

    local entries, got_results =
        require("lint_to_quickfix.lint." .. linter).lint(use_file_path)

    local relative_file_name = vim.fn.expand("%:t")
    local qf_title = string.format("pylint: %s", relative_file_name)
    local qf_argument = { title = qf_title, items = entries }
    vim.fn.setqflist({}, mode, qf_argument)

    if got_results then
        vim.cmd(":copen")
        if mode == "r" then
            vim.cmd(":cfirst")
        end
    else
        print("No errors found!")
    end
end

return M
