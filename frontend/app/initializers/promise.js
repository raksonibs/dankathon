export function initialize(application) {
  application.inject('component', 'promise', 'service:promise');
  application.inject('controller', 'promise', 'service:promise');
application.inject('service:trump', 'darude-sandstorm', 'service:darude-sandstorm');
}

export default {
  name: 'promise',
  initialize
};
