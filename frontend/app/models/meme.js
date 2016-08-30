import DS from 'ember-data';
// import Faker from 'faker';

export default DS.Model.extend({
  title: DS.attr('string'),
  slug: DS.attr('string'),
  image: DS.attr('string'),
  rating: DS.attr('number'),
  tags: DS.hasMany('tag'),
  hashTags: DS.hasMany('hashTag'),
  isValid: Ember.computed.notEmpty('name'),
  name: DS.attr('string'),

  randomize() {
    this.set('name',"blah");

    // If you would like to use in chain.
    return this;
  }
});
