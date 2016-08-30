import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['title'],
  title: "",
  isModalVisible: false,
  init() {
    // let promise = this.get('promise').start();
    // promise.addItem("test");
    // console.log(promise);
    // promise.addDelayedItem("cat");
    // console.log(promise);
  }
});
