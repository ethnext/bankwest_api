Gem::Specification.new do |spec|
  spec.name = "bankwest_api"
  spec.version = "0.0.2"
  # transformative work from source:
  #   https://paymentgateway.commbank.com.au/api/documentation/apiDocumentation/
  # REST (Representational State Transfer)
  # using both HTML Reference AND WADL
  # by Ethan at VenueNext
  spec.author = "Ethan/VenueNext"
  spec.summary = "bankwest api"
  spec.files = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]
end
