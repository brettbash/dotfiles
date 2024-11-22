local ls = require("luasnip")
local s = ls.snippet
-- local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("twig", {
  s({
    trig = "cm1",
    name = "Comment Level 01",
  }, {
    t({ "{# π ----", "// :: " }),
    i(1, "TITLE"),
    t({ "", "// : ---------------------------------- #}", "" }),
    i(0),
  }),

  s({
    trig = "cm2",
    name = "Comment Level 02",
  }, {
    t("{# :: "),
    i(1, "Title"),
    t({ "", "{+} ---------------------------------- #}", "" }),
    i(0),
  }),

  s({
    trig = "cm3",
    name = "Comment Level 03",
  }, {
    t("{# :: "),
    i(1, "Title"),
    t({ " ------------ #}", "" }),
    i(0),
  }),

  s({
    trig = "!!",
    name = "File Info",
  }, {
    t({ "{#", "" }),
    t({ "    @name " }),
    i(1, "Name"),
    t({ "", "    @desc " }),
    i(2, "Description"),
    t({ "", "    @type " }),
    i(3, "type"),
    t({ "", "#}", "", "" }),
    i(0),
  }),

  s({
    trig = "el",
    name = "Element",
  }, {
    t({ "<" }),
    i(1, "div"),
    t({ "", '    class="', "        " }),
    i(2, ""),
    t({ "", '    "', "" }),
    t({ ">", "    " }),
    i(3, ""),
    t({ "", "</" }),
    i(4, "div"),
    t({ ">", "" }),
    i(0),
  }),
})
