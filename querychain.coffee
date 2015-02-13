class QueryChain
  chains = []

  @_chain: (name) ->
    ->
      config = (chain for chain in chains when chain.name is name)[0]

      collection = config.collection?._collection or config.collection
      if collection? and collection isnt @collection
        throw new Error "QueryChain '#{name}' is not allowed on collection '#{@collection.name}'"

      options = {}
      options.fields = @fields if @fields?
      options.limit = @limit if @limit?
      options.skip = @skip if @skip?

      if typeof config.query is 'function'
        result = config.query.apply @, _.toArray(arguments)
        query = _.extend @matcher._selector, result
      else
        query = _.extend @matcher._selector, config.query
      options = _.extend options, config.options

      @collection.find query, options

  @add: (params) ->
    for key, options of params
      options.name = key
      defaultOptions =
        collection: null
        query: {}
        options: {}

      _.extend defaultOptions, options

      for chain in chains when chain.name is options.name
        throw new Error("QueryChain '#{chain.name}' is already defined")

      chains.push options

      Mongo.Cursor.prototype[options.name] = @_chain options.name


  @reset: ->
    Mongo.Cursor.prototype[chain.name] = undefined for chain in chains
    chains = []
