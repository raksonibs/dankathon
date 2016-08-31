import Ember from 'ember';

export default Ember.Component.extend({
  actions: {
    buildingWallComp() {
      this.get('buildingWall')(this.getProperties('no', 'yes'));
    }
  }
});
