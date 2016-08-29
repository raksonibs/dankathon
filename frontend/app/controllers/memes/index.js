import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['title'],
  title: "",
  actions: {
    toggleModal(meme) {
      console.log('making meme modal visible');
      this.set('isModalVisible', true);
    }
  }
});
