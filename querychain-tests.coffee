Tinytest.add 'QueryChain - simple query', (test) ->
  posts = new Mongo.Collection null

  posts.insert
    name: 'Post 1'
    comments: 0

  posts.insert
    name: 'Post 2'
    comments: 5

  QueryChain.add
    name: 'withComments'
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
    name: 'withComments'
    query:
      comments:
        $gt: 0

  QueryChain.add
    name: 'fromMax'
    query:
      author: "Max"

  result = posts.find().withComments().fromMax()

  test.equal result.count(), 0
  QueryChain.reset()
