import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['meme-modal'],
  tagName: 'div',
  animated: Ember.computed('isModalVisible', function() {
    return this.get('isModalVisible') === true ? 'active' : '';
  }),
  actions: {
    toggleModal() {
      this.toggleProperty('isModalVisible');
    }
  }
});
