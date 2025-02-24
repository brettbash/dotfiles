--[=====[
This plugin allows you to globally set the .markdownlint.yaml file instead of 
doing it on a per :pwd directory

If you add the file to the :pwd directory, that file will take precedence
instead of the --config file specified below lamw25wmal
--]=====]

return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", os.getenv("HOME") .. ".markdownlint.yaml", "--" },
      },
    },
  },
}
