return {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSesionToggle", "LLMSelectedTextHandler" },
    config = function()
      require("llm").setup({
        -- ChatGLM
        max_tokens = 4096,
        url = "https://open.bigmodel.cn/api/paas/v4/chat/completions",
        model = "glm-4-flash",
        prefix = {
          user = { text = "😃  ", hl = "Title" },
          assistant = { text = "   ", hl = "Added" },
          -- assistant = { text = "⚡ ", hl = "Added" },
        },
        save_session = true,
        max_history = 15,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = "n", key = "<C-c>" },
          ["Input:Resend"]      = { mode = "n", key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = "n", key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = "n", key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>l" },
          ["Session:Close"]     = { mode = "n", key = "<esc>" },
        },
      })
    end,
    keys = {
      { "<leader>L", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
      { "<leader>ll", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Toggle LLMSession" },
      { "<leader>le", mode = "v", "<cmd>LLMSelectedTextHandler 请解释下面这段代码<cr>", desc = "LLM: Explain Selected Code" },
      { "<leader>lt", mode = "x", "<cmd>LLMSelectedTextHandler 英译汉<cr>", desc = "LLM: Translate into Chinese" },
      { "<leader>lo", mode = "x", "<cmd>LLMSelectedTextHandler 优化代码<cr>", desc = "LLM: Optimize Code" },
      { "<leader>lT", mode = "n", "<cmd>LLMAppHandler Translate<cr>", desc = "LLM: Translate" },
      -- { "<leader>c", mode = "x", "<cmd>LLMAppHandler TestCode<cr>" },
      -- { "<leader>lc", mode = "x", "<cmd>LLMAppHandler OptimCompare<cr>" },
      -- { "<leader>lo", mode = "x", "<cmd>LLMAppHandler OptimizeCode<cr>" },
      -- { "au", mode = "n", "<cmd>LLMAppHandler UserInfo<cr>" },
    },
  }
