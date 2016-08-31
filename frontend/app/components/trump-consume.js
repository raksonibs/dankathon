import Ember from 'ember';

export default Ember.Component.extend({
  showTrumps() {
    let tCont = Ember.$('.trumps-everywhere')[0];
    var img;

    for (var i = 0; i < 100; i++) {
        setTimeout(function() {
          img = document.createElement('img');
          img.src = '/assets/trump-askance.png';
          img.style.display = "fixed";
          img.className = "rand-trump"
          img.style.top = (Math.random() * 100) + "%";
          img.style.left = (Math.random() * 100) + "%";
          tCont.appendChild(img);
        }, 1000 - (Math.pow(2, i)));
    }

  },

  didUpdate() {
    this.showTrumps();
  }
});
