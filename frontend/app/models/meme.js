import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  image: DS.attr('string'),
  rating: DS.attr('number'),
  tags: DS.hasMany('tag'),
  hashTags: DS.hasMany('hashTag')
});
