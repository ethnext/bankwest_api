Gem::Specification.new do |spec|
  spec.name = "bankwest_api"
  spec.version = "0.0.1"
  # transformative work from source:
  #   https://paymentgateway.commbank.com.au/api/documentation/apiDocumentation/
  # REST (Representational State Transfer)
  # using both HTML Reference AND WADL
  # by Ethan at VenueNext
  spec.author = "Ethan/VenueNext"
  spec.summary = "bankwest api"
  spec.files = %w(bankwest_rest_json.openapi3.yml bankwest_rest_json.wadl.xml lib/bankwest_api.rb)
  spec.require_paths = ["lib"]
end
