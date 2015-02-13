# QueryChain
This package enables chaining mongo cursors like this:
````javascript
Posts.find().fromMax().withComments()
````

## Installation
````
meteor add maxnowack:querychain
````

## Usage

````javascript
Posts = new Mongo.Collection('posts');

// add a chain method
QueryChain.add({
  withComments: { // name of the method
    query: { // a mongo query
      comments: {
        $gt: 0
      }
    }
  }
});

// it's also possible, to define a function to provide a query
QueryChain.add({
  from: {
    query: function(name){
      return {
        author: name
      }
    }
  }
});

Posts.find().withComments() // returns a cursor for the query speficied above

// you can also chain multiple methods:
QueryChain.add({
  fromMax: {
    query: {
      author: 'Max'
    }
  }
});

Posts.find().fromMax().withComments()


// or limit methods to specific collections
QueryChain.add({
  notFromMax: {
    collection: Posts
    query: {
      author: {
        $ne: 'Max'
      }
    }
  }
});
````
