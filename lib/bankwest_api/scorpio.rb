require 'scorpio'
require 'bankwest_api'

module BankwestAPI
  Document = Scorpio::OpenAPI::V3::Document.new(::YAML.load(BANKWEST_OPENAPI3_YML))

  # GENERATED (relying on activesupport) vaguely like
  # puts BankwestAPI::Document.components.schemas.select { |k,v| ['object', nil].include?(v['type']) }.keys.map { |k| "#{k.camelize} = ... '#{k}'" }
  Errors        = JSI.class_for_schema(Document.components.schemas['errors'])
  TransactionPutRequest = JSI.class_for_schema(Document.components.schemas['transactionPutRequest'])
  TransactionPutResponse = JSI.class_for_schema(Document.components.schemas['transactionPutResponse'])
  Token         = JSI.class_for_schema(Document.components.schemas['token'])
  SourceOfFunds = JSI.class_for_schema(Document.components.schemas['sourceOfFunds'])
  Card         = JSI.class_for_schema(Document.components.schemas['card'])

  # @param limit [#to_s]
  # @param query [#to_hash]
  # @param faraday_builder [#call]
  # @param merchantId [#to_s]
  # @yield [BankwestAPI::Token]
  def self.each_token(limit: nil, query: nil, faraday_builder: , merchantId: , &block)
    raise(ArgumentError, "no block given") unless block

    query_params = {}
    query_params['limit'] = limit if limit
    query_params['query'] = JSON.generate(query) if query
    token_search = Document.paths["/merchant/{merchantId}/tokenSearch"]['get'].build_request(
      faraday_builder: faraday_builder,
      path_params: {'merchantId' => merchantId},
      query_params: query_params,
    )
    next_page = -> (last_page_ur) do
      nextPage = last_page_ur.response.body_object['nextPage']
      request = last_page_ur.scorpio_request.dup
      if nextPage
        request.query_params = {'nextPage' => nextPage}
        request.run_ur
      else
        nil
      end
    end
    token_search.each_page_ur(next_page: next_page) do |page_ur|
      page = page_ur.response.body_object
      if page['page'] && page['page']['token']
        page['page']['token'].each(&block)
      end
    end
  end

  class Card
    def prefix
      number_match['prefix']
    end
    def suffix
      number_match['suffix']
    end
    def number_match
      return @number_match if instance_variable_defined?(:@number_match)
      @number_match = number && number.match(/\A(?<prefix>\d+)x+(?<suffix>\d+)\z/)
    end
  end
end
