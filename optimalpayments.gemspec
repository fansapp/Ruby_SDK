Gem::Specification.new do |s|
  s.name        = "optimalpayments"
  s.version     = "1.0.0"
  s.date        = "2014-03-11"
  s.summary     = "Optimal API"
  s.description = "Optimal API integration with Ruby"
  s.authors     = "Optimal Payments"
  s.email       = "contact@optimalpayments.com"
  s.homepage    = "http://www.optimalpayments.com/"
  s.files       = Dir["lib/*.rb"] + Dir["lib/optimal/*.rb"] + Dir["lib/optimal/customer_vault/*.rb"] + Dir["lib/optimal/card_payments/*.rb"] + Dir["lib/optimal/errors/*.rb"] + Dir["lib/optimal/hosted_payment/*.rb"]
  s.license     = "MIT"

  s.add_development_dependency "rspec", "~> 3.0"
end