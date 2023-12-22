return {
  "chrisgrieser/nvim-various-textobjs",
  lazy = true,
  keys = { "gx" },
  config = function()
    vim.keymap.set("n", "gx", function()
      require("various-textobjs").url()
      local foundURL = vim.fn.mode():find("v")
      if not foundURL then
        return
      end
      vim.cmd.normal({ '"zy', bang = true })
      local url = vim.fn.getreg("z")
      local opener = ""
      if vim.fn.has("macunix") == 1 then
        opener = "open"
      elseif vim.fn.has("linux") == 1 then
        opener = "xdg-open"
      end
      local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
      vim.fn.system(openCommand)
    end, { desc = "URL Opener" })
  end,
}
