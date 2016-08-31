import Ember from 'ember';

export default Ember.Route.extend({
  darude: Ember.inject.service('darude-sandstorm'),
  trump: Ember.inject.service('darude-sandstorm'),
  trumpGame: Ember.inject.service('trump'),
  dankText: null,
  catsAreDogs: false,
  showTrump: false,
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
  trumpCount: Ember.computed('trumpGame', 'dankText', function() {
    return this.get('dankText');
  }),
  actions: {
    checkForDank(dankText) {
      let darude = this.get('darudeSong');
      let trump = this.get('trumpHorn');
      let trumpGame = this.get('trumpGame');

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

      if ('trump' === dankTextSet || dankTextSet.match(/trump/g).length >= 2) {        
        var outcome = trumpGame.setTrumpCount(dankTextSet.match(/trump/g).length);
        if (outcome !== false) {          
          this.controller.set(outcome["key"], outcome["value"]);
        }
      }

      // if (/darude/.exec(dankTextSet)) {        
      //   darude.playSong();
      // } else {
      //   darude.stopSong();
      // }

      // if (/trump/.exec(dankTextSet)) {        
      //   trump.playSong();
      // } else {
      //   trump.stopSong();
      // }


    }
  }
});
