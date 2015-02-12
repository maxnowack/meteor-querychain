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
  name: 'withoutComments', // name of the method
  query: { // a mongo query
    comments: {
      $gt: 0
    }
  }
});

Posts.find().withComments() // returns a cursor for the query speficied above

// you can also chain multiple methods:
QueryChain.add({
  name: 'fromMax',
  query: {
    author: 'Max'
  }
});

Posts.find().fromMax().withComments()
````
