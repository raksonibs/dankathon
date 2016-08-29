import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['meme-modal'],
  tagName: 'div',
  actions: {
    toggleModal() {
      this.toggleProperty('isModalVisible');
    }
  }
});
