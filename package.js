Package.describe({
  name: 'maxnowack:querychain',
  version: '0.2.0',
  summary: 'This package enables chaining mongo cursors for Meteor',
  git: 'https://github.com/maxnowack/meteor-querychain/'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.3.1');
  api.use('coffeescript');
  api.addFiles('querychain.coffee');
  api.export('QueryChain');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('coffeescript');
  api.use('maxnowack:querychain');
  api.addFiles('querychain-tests.coffee');
});
