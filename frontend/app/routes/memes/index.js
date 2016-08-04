import Ember from 'ember';

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

  // setupController(controller, models) {
  //   controller.set('memes', models.memes);
  //   // controller.set('filteredMemes', models.filteredMemes);
  // }
});
