spelling::spell_check_files(
  list.files(pattern = "\\.tex$"),
  ignore = scan("WORDLIST", ""),
  lang = "en-US"
)
