import Ember from 'ember';
import ENV from '../config/environment';

export function fullUrl(params) {
  const url = params[0];
  let regex = new RegExp("^(http[s]?:\\/\\/(www\\.)?|ftp:\\/\\/(www\\.)?|www\\.){1}([0-9A-Za-z-\\.@:%_\+~#=]+)+((\\.[a-zA-Z]{2,3})+)(/(.)*)?(\\?(.)*)?");
  if (regex.test(url)) {
    return url;
  } else {    
    return `${ENV.serverURL}\\${url}`;
  }

}

export default Ember.Helper.helper(fullUrl);
