-- Load with :luafile .nvim.lua from this repository, or enable Neovim's exrc.
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
local cruft = root .. "/build/formatter"
vim.fn.mkdir(cruft, "p")
vim.filetype.add({ extension = { tikz = "tex", sty = "tex" } })
require("conform").setup({
  formatters = {
    modeling_latexindent = {
      inherit = "latexindent",
      prepend_args = function(_, ctx)
        if ctx.filename:sub(1, #root + 1) == root .. "/" then
          return { "-l=" .. root .. "/.latexindent.yaml", "-c=" .. cruft }
        end
        return {}
      end,
    },
  },
  formatters_by_ft = {
    tex = { "modeling_latexindent" },
    plaintex = { "modeling_latexindent" },
  },
})
