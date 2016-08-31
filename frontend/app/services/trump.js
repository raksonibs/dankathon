import Ember from 'ember';

export default Ember.Service.extend({
  airHorn: Ember.inject.service('darude-sandstorm'),
  trumpCount: 0,
  init() {
    this._super(...arguments);    
  },

  increaseTrump() {
    this.incrementProperty('trumpCount', 1);
  },

  getTrumpCount() {
    return this.get('trumpCount');
  },

  airHornPlay() {
    let airHornService = this.get('airHorn');
    airHornService.changeSong('/assets/airhorn.mp3');
    airHornService.playSong();
    return false;
  },

  showTrump() {
    // this.controllerFor('dank').set('catsAreDogs', true);
    
    return {
      "key": "showTrump",
      "value": true
    }
  },

  manyTrumps() {
    return {
      "key": "manyTrumps",
      "value": true
    }
  },

  buildTheWall() {
    return {
      "key": "buildTheWall",
      "value": true
    }
  },

  fourTrumps() {
    return {
      "key": "fourTrumps",
      "value": true
    }
  },

  setTrumpCount(number) {
    this.set('trumpCount', number);
    switch(number) {
      case 1: 
        return this.airHornPlay();
        break;
      case 2:
        return this.showTrump();
        break;
      case 3:
        return this.manyTrumps();      
        break;
      case 4:
        return this.fourTrumps();      
        break;
      case 5:
        return this.buildTheWall();      
        break;
    }
    // console.log(this.getTrumpCount());
  }
});
