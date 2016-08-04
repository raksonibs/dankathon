import Ember from 'ember';
import EmberUploader from 'ember-uploader';
import ENV from '../config/environment';

export default EmberUploader.FileField.extend({
  classNames: ['upload'],
  signingUrl: '',

  filesDidChange: function(files) {
    this.get('isSearchingUpdate')();
    
    const uploader = EmberUploader.Uploader.create({
      // url: this.get('url'),
      url: ENV.apiBaseURL + '/upload',
      method: 'POST'
    });

    // const uploader = EmberUploader.S3Uploader.create({
    //   signingUrl: this.get('signingUrl')
    // });

    console.log('should be calling update');
    console.log(files);

    uploader.on('progress', e => {
      // Handle progress changes
      // Use `e.percent` to get percentage
      console.log(e.percent);
    });

    uploader.on('didUpload', e => {
      // Handle finished upload
      var thisState = this;
      setTimeout(function() {

        thisState.get('isSearchingUpdate')();
      }, 10000)
      console.log('finished uploading');
      //  let uploadedUrl = $(response).find('Location')[0].textContent;
      // // http://yourbucket.s3.amazonaws.com/file.png
      // uploadedUrl = decodeURIComponent(uploadedUrl);
    });

    uploader.on('didError', (jqXHR, textStatus, errorThrown) => {
      // Handle unsuccessful upload
      console.log('error');
    });

    if (!Ember.isEmpty(files)) {
      // this second argument is optional and can to be sent as extra data with the upload
      uploader.upload(files[0], { });
    }
  }
});