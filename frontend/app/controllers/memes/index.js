import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['title'],
  title: "",
  isModalVisible: false,
  actions: {
    // toggleModal(meme) {
    //   console.log('making meme modal visible');
    //   this.set('isModalVisible', true);
    // }
  }
});
