Tinytest.add 'QueryChain - simple query', (test) ->
  posts = new Mongo.Collection null

  posts.insert
    name: 'Post 1'
    comments: 0

  posts.insert
    name: 'Post 2'
    comments: 5

  QueryChain.add
    withComments:
      query:
        comments:
          $gt: 0

  result = posts.find().withComments().fetch()

  test.equal result.length, 1
  test.equal result[0].comments, 5
  QueryChain.reset()

Tinytest.add 'QueryChain - simple chained query', (test) ->
  posts = new Mongo.Collection null

  posts.insert
    name: 'Post 1'
    comments: 0
    author: "Max"

  posts.insert
    name: 'Post 2'
    comments: 5
    author: "not Max"

  QueryChain.add
    withComments:
      query:
        comments:
          $gt: 0
    fromMax:
      query:
        author: "Max"

  result = posts.find().withComments().fromMax()

  test.equal result.count(), 0
  QueryChain.reset()

Tinytest.add 'QueryChain - simple query on specific collection', (test) ->
  posts = new Mongo.Collection null
  notPosts = new Mongo.Collection null

  posts.insert
    name: 'Post 1'
    comments: 0

  posts.insert
    name: 'Post 2'
    comments: 5

  QueryChain.add
    withComments:
      collection: posts
      query:
        comments:
          $gt: 0

  failed = false
  result = posts.find().withComments().fetch()

  try
    notPosts.find().withComments()
  catch e
    failed = true


  test.equal result.length, 1
  test.equal result[0].comments, 5
  test.isTrue failed
  QueryChain.reset()

Tinytest.add 'QueryChain - function query', (test) ->
  posts = new Mongo.Collection null

  posts.insert
    name: 'Post 1'
    author: 'Brian'
    comments: 0

  posts.insert
    name: 'Post 2'
    author: 'Max'
    comments: 5

  QueryChain.add
    from:
      query: (name) ->
        author: name

  result = posts.find().from('Max').fetch()

  test.equal result.length, 1
  test.equal result[0].author, 'Max'
  QueryChain.reset()
