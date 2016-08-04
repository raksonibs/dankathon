import Ember from 'ember';
import ENV from '../config/environment';
import fullUrl from 'frontend/helpers/full-url';

export function imageExists(params) {
  // let url = fullUrl(params);
  let url = params[0];
  // let regex = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?");
  // if (regex.test(url)) {
  //   url = url;
  // } else {    
  //   url =`${ENV.serverURL}\\${url}`;
  // }
  
  console.log('setting image');

  // let http = new XMLHttpRequest();

  // try {
  //   http.open('HEAD', url, false);
  //   http.send();
  //   return http.status != 404;
  // } catch(e) {
  //   return false;  
  // }

  // let img = new Image();

  // try {

  //   img.onload = function() {
  //     console.log('true');
  //     return true;
  //   }

  //   img.onerror = function(error) {
  //     console.log('false');
  //     return false;
  //   }
  // } catch(e) {
  //   console.log('error-false');
  //   return false;
  // }

  // img.src = url;

  return true;

}

export default Ember.Helper.helper(imageExists);
