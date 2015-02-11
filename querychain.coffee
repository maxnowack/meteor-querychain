class QueryChain
  chains = []

  @_chain: (name) ->
    ->
      config = (chain for chain in chains when chain.name is name)[0]

      if config.collection? and config.collection isnt @collection.name
        throw new Error "QueryChain '#{name}' is not allowed on collection '#{@collection.name}'"

      options = {}
      options.fields = @fields if @fields?
      options.limit = @limit if @limit?
      options.skip = @skip if @skip?

      query = _.extend @matcher._selector, config.query
      options = _.extend options, config.options

      @collection.find query, options

  @add: (options) ->
    defaultOptions =
      collection: null
      query: {}
      options: {}

    _.extend defaultOptions, options

    throw new Error("QueryChain name is required") unless options.name

    for chain in chains when chain.name is options.name
      throw new Error("QueryChain '#{chain.name}' is already defined")

    chains.push options

    Mongo.Cursor.prototype[options.name] = @_chain options.name


  @reset: ->
    Mongo.Cursor.prototype[chain.name] = undefined for chain in chains
    chains = []
