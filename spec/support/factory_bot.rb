require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
end
