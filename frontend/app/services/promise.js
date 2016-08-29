import Ember from 'ember';
import { PromiseTest } from '../utils/promise-test';

export default Ember.Service.extend({
  isServiceFactory: true,
  start() {
    let p = new PromiseTest();
    
    return p;
  }
});
