export function initialize(application) {
  application.inject('component', 'promise', 'service:promise');
  application.inject('controller', 'promise', 'service:promise');
}

export default {
  name: 'promise',
  initialize
};
