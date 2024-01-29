local function openURL(url)
  local opener
  if vim.fn.has("macunix") == 1 then
    opener = "open"
  elseif vim.fn.has("linux") == 1 then
    opener = "xdg-open"
  elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
    opener = "start"
  end
  local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
  vim.fn.system(openCommand)
end

return {
  "chrisgrieser/nvim-various-textobjs",
  lazy = true,
  keys = { "gx" },
  config = function()
    vim.keymap.set("n", "gx", function()
      require("various-textobjs").url()
      local foundURL = vim.fn.mode():find("v")
      if foundURL then
        vim.cmd.normal({ '"zy', bang = true })
        local url = vim.fn.getreg("z")
        openURL(url)
      else
        -- find all URLs in buffer
        local urlPattern = require("various-textobjs.charwise-textobjs").urlPattern
        local bufText = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
        local urls = {}
        for url in bufText:gmatch(urlPattern) do
          table.insert(urls, url)
        end
        if #urls == 0 then
          return
        end
        -- select one, use a plugin like dressing.nvim for nicer UI for
        -- `vim.ui.select`
        vim.ui.select(urls, { prompt = "Select URL:" }, function(url)
          if url then
            openURL(url)
          end
        end)
      end
    end, { desc = "URL Opener" })
  end,
}
