Handlers = {
  log:         Strategies::Log.new(Rails.root.join "log", "normal.log"),
  awesome_log: Strategies::Log.new(Rails.root.join "log", "awesome.log"),
  speak:       Strategies::Say.new,
  wat:         Strategies::Fail.new
}

RuleSet = [
  Rule.build("word",       [:log]),
  Rule.build("aardwolf",   [:speak, :awesome_log]),
  Rule.build("turbolinks", [:speak, :wat])
]
