import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['meme_lettering'],
  click: function(evt) {
    console.log('tagname', evt.target.tagName);
  },

  mouseEnter: function() {
    console.log('mouseEnter');
    const letters = Ember.$('.letter');
    for (let i=0; i<letters.length;i++) {
      letters[i].classList.add('coloured');
    }
  },

  mouseLeave: function() {    
    console.log('mouseLeave');
    const letters = Ember.$('.letter');
    for (let i=0; i<letters.length;i++) {
      letters[i].classList.remove('coloured');
    }
  }
});
