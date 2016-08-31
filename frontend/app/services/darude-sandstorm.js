import Ember from 'ember';

export default Ember.Service.extend({
  song: null,
  playingSong: null,
  init(song) {
    this._super(...arguments);
    this.set('song', '');
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
