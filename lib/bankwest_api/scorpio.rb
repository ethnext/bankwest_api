require 'scorpio'
require 'bankwest_api'

module BankwestAPI
  Document = Scorpio::OpenAPI::V3::Document.new(::YAML.load(BANKWEST_OPENAPI3_YML))

  # GENERATED (relying on activesupport) vaguely like
  # puts BankwestAPI::Document.components.schemas.select { |k,v| ['object', nil].include?(v['type']) }.keys.map { |k| "#{k.camelize} = ... '#{k}'" }
  Errors        = JSI.class_for_schema(Document.components.schemas['errors'])
  TransactionPut = JSI.class_for_schema(Document.components.schemas['transactionPut'])
  Token         = JSI.class_for_schema(Document.components.schemas['token'])
  SourceOfFunds = JSI.class_for_schema(Document.components.schemas['sourceOfFunds'])
end
