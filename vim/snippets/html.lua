local ls = require("luasnip")
local s = ls.snippet
-- local c = ls.choice_node
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("html", {
  s({
    trig = "cm1",
    name = "Comment Level 01",
  }, {
    t({ "{{# π ----", "// :: " }),
    i(1, "TITLE"),
    t({ "", "// : ---------------------------------- #}}", "" }),
    i(0),
  }),

  s({
    trig = "cm2",
    name = "Comment Level 02",
  }, {
    t("{{# :: "),
    i(1, "Title"),
    t({ "", "{+} ---------------------------------- #}}", "" }),
    i(0),
  }),

  s({
    trig = "cm3",
    name = "Comment Level 03",
  }, {
    t("{{# :: "),
    i(1, "Title"),
    t({ " ------------ #}}", "" }),
    i(0),
  }),

  s({
    trig = "tag",
    name = "Antlers Tag Braces",
  }, {
    t("{{ "),
    i(1, "var"),
    t(" }}"),
    i(0),
  }),

  s({
    trig = "cmt",
    name = "Antlers Comment Braces",
  }, {
    t("{{ "),
    i(1, "var"),
    t(" }}"),
    i(0),
  }),
})
