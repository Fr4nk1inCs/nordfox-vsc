local palette = require('nightfox.palette').load('dayfox')
local specs = require('nightfox.spec').load('dayfox')
local file = io.open('dayfox.json', 'w')

if not file then
  error('Could not open dayfox.json for writing')
end

---@diagnostic disable-next-line: undefined-global
local dump = vim.json.encode({
  palette = {
    ansi = {
      black = palette.black,
      red = palette.red,
      green = palette.green,
      yellow = palette.yellow,
      blue = palette.blue,
      magenta = palette.magenta,
      cyan = palette.cyan,
      white = palette.white,
      orange = palette.orange,
      pink = palette.pink,
    },
    bg0 = palette.bg0,
    bg1 = palette.bg1,
    bg2 = palette.bg2,
    bg3 = palette.bg3,
    bg4 = palette.bg4,
    fg0 = palette.fg0,
    fg1 = palette.fg1,
    fg2 = palette.fg2,
    fg3 = palette.fg3,
    sel0 = palette.sel0,
    sel1 = palette.sel1,
    comment = palette.comment,
  },
  specs = {
    syntax = {
      bracket = specs.syntax.bracket,
      builtin0 = specs.syntax.builtin0,
      builtin1 = specs.syntax.builtin1,
      builtin2 = specs.syntax.builtin2,
      builtin3 = specs.syntax.builtin3,
      comment = specs.syntax.comment,
      conditional = specs.syntax.conditional,
      const = specs.syntax.const,
      dep = specs.syntax.dep,
      field = specs.syntax.field,
      func = specs.syntax.func,
      ident = specs.syntax.ident,
      keyword = specs.syntax.keyword,
      number = specs.syntax.number,
      operator = specs.syntax.operator,
      preproc = specs.syntax.preproc,
      regex = specs.syntax.regex,
      statement = specs.syntax.statement,
      string = specs.syntax.string,
      type = specs.syntax.type,
      variable = specs.syntax.variable,
    },
    diag = {
      error = specs.diag.error,
      hint = specs.diag.hint,
      info = specs.diag.info,
      warn = specs.diag.warn,
    },
    diag_bg = {
      error = specs.diag_bg.error,
      hint = specs.diag_bg.hint,
      info = specs.diag_bg.info,
      warn = specs.diag_bg.warn,
    },
    diff = {
      add = specs.diff.add,
      change = specs.diff.change,
      delete = specs.diff.delete,
      text = specs.diff.text,
    },
    git = {
      add = specs.git.add,
      removed = specs.git.removed,
      changed = specs.git.changed,
      conflict = specs.git.conflict,
      ignored = specs.git.ignored,
    },
  },
})

file:write(dump)
file:close()
