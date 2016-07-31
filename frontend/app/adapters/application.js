import JSONAPIAdapter from 'ember-data/adapters/json-api';
import Ember from 'ember';
import ENV from '../config/environment';

export default JSONAPIAdapter.extend({
  host: ENV.serverURL,
  namespace: ENV.apiNamespace,
  coaleseFindRquests: true,
  pathForType(type) {
    let underscored = Ember.String.underscore(type);
    return Ember.String.pluralize(underscored);
  }
});