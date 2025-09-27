# FactoryBot configuration for RSpec
# Provides concise syntax (build/create) and an optional CI lint step.

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # Enable factory linting in CI or on demand by setting FACTORY_LINT=1
  if ENV['FACTORY_LINT']
    config.before(:suite) do
      FactoryBot.lint
    end
  end
end
