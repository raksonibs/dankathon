import Ember from 'ember';

export default Ember.Service.extend({
  song: null,
  playingSong: null,
  init() {
    this._super(...arguments);
    this.set('song', '/assets/darude.mp3');
    this.set('playingSong', new Audio(this.get('song')));
  },

  changeSong(url) {
    this.set('song', url);
    this.set('playingSong', new Audio(this.get('song')));
  },

  playSong() {
    this.get('playingSong').play();
  },

  stopSong() {
    this.get('playingSong').pause();
  }
});
