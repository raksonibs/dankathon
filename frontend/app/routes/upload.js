import Ember from 'ember';

export default Ember.Route.extend({
  isSearching: false,
  actions: {
    isSearchingUpdate() {
      console.log('changing isSearching from ' + this.get('isSearching'));
      this.toggleProperty('isSearching');
      console.log('to ' + this.get('isSearching'));
    }
  }
});
