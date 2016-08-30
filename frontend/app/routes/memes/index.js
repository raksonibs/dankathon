import Ember from 'ember';
import { PromiseTest } from "../../utils/promise-test";
import InfinityRoute from "ember-infinity/mixins/route";

export default Ember.Route.extend(InfinityRoute, {
  queryParams: {
    title: {
      refreshModel: true
    }
  },
  model(params) { 
    // return this.store.query('meme', params);
    return this.infinityModel("meme", { perPage: 50, startPage: 1});
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
  },

  afterModelUpdated(totalPages) {

  }
});
