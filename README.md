# QueryChain
This package enables chaining mongo cursors for Meteor

## Installation
````
meteor add maxnowack:query-chain
````

## Usage

First add a chain method

````javascript
Posts = new Mongo.Collection('posts');

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
