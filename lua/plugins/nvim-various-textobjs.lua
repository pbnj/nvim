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
        if url then
          vim.ui.open(url)
        end
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
            vim.ui.open(url)
          end
        end)
      end
    end, { desc = "URL Opener" })
  end,
}
