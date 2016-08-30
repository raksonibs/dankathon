import Ember from 'ember';

export default Ember.Route.extend({
  darude: Ember.inject.service('darude-sandstorm'),
  trump: Ember.inject.service('darude-sandstorm'),
  darudeSong: Ember.computed('darude', function() {
    let darude = this.get('darude');
    darude.changeSong('/assets/darude.mp3');
    return darude;
  }),

  trumpHorn: Ember.computed('trump', function() {
    let trump = this.get('trump');
    trump.changeSong('/assets/airhorn.mp3');
    return trump;
  }),
  actions: {
    checkForDank(dankText) {
      let darude = this.get('darudeSong');
      let trump = this.get('trumpHorn');

      let dankTextSet = dankText.target.value;

      if (/dank/.exec(dankTextSet)) {
        this.controller.set('super-dank', true);
      } else {
        this.controller.set('super-dank', false);
      }

      if (/cat/.exec(dankTextSet)) {
        this.controller.set('rotate', true);
      } else {
        this.controller.set('rotate', false);
      }

      if (/darude/.exec(dankTextSet)) {        
        darude.playSong();
      } else {
        darude.stopSong();
      }

      if (/trump/.exec(dankTextSet)) {        
        darude.playSong();
      } else {
        darude.stopSong();
      }

      if (/wall/.exec(dankTextSet)) {        
        game.buildWallStart();
      } else {
        game.buildWallStop();
      }
    }
  }
});
