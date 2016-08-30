import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('memes', { path: '/'}, function() {
    this.route('show', { path: '/memes/:meme_id'});
  });
  this.route('upload');
  this.route('dank');
});

export default Router;
