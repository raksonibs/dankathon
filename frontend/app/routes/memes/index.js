import Ember from 'ember';
import { PromiseTest } from "../../utils/promise-test";

export default Ember.Route.extend({
  queryParams: {
    title: {
      refreshModel: true
    }
  },
  model(params) {
    // return Ember.RSVP.hash({
    //   memes: this.store.findAll('meme')
    //   // filteredMemes: this.store.query('meme', {title: 'c'})
    // })

    return this.store.query('meme', params);
  },

  setupController(controller, models) {
    var p = new PromiseTest(models.toArray());
    var promises = p.cleanImages();

    Promise.all(promises).then(function(success) {      
      console.log("IT WORKED!");
      var images = success.filter((image) => { return image !== undefined });
      controller.set('model', images);
    }, function(err) {
      console.log('error over here', err);
    })
    // controller.set('filteredMemes', models.filteredMemes);
  }
});
