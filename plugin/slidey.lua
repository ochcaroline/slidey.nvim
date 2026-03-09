local function run_slidey()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or vim.fn.filereadable(file) == 0 then
    vim.notify("slidey: not a readable file", vim.log.levels.ERROR)
    return
  end
  if vim.bo.filetype ~= "markdown" then
    vim.notify("slidey: not a markdown file", vim.log.levels.ERROR)
    return
  end

  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.fn.termopen(
    { "slidey", file },
    { on_exit = function() vim.cmd("tabclose") end }
  )
  vim.bo[buf].modifiable = false
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("Slidey", run_slidey, {})
vim.keymap.set("n", "<leader>ss", run_slidey, { desc = "Slidey: present current file" })
