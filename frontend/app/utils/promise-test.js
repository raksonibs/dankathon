export class PromiseTest {
  constructor(items) {
    this.items = items || [];
  }

  addItem(item) {
    this.items.push(item);
  }

  testImage(url, item) {
    return new Promise(function (resolve, reject) {
        var timeout = 5000;
        var timer, img = new Image();
        img.onerror = img.onabort = function () {
            clearTimeout(timer);
            // reject("error with this image: " + url);
            resolve(undefined);
        };
        img.onload = function () {
            clearTimeout(timer);
            resolve(item);
        };
        // timer = setTimeout(function () {
        //     // reset .src to invalid URL so it stops previous
        //     // loading, but doesn't trigger new load
        //     img.src = "//!!!!/test.jpg";
        //     reject("timeout");
        // }, timeout);

        img.src = url;
      });
  }

  cleanImages() {
    console.log("cleaning images");
    var thisState = this;
    var promises = [];
    thisState.items.forEach((image) => {
      promises.push(this.testImage(image.toJSON().image, image));
    });

    return promises;
  }

  promiseAdd(item) {
    var thisState = this;
    return new Promise(function(resolve, reject) {
      let val;
      setTimeout(function() {
        val = true;
        thisState.items.push(item);
        if (val === true) {
          resolve("worked");
        } else {
          reject(Error("broken"));
        }
      }, 1000);

    })
  }

  addDelayedItem(item) {
    let p = this.promiseAdd(item);
    let thisState = this;
    p.then(function(result) {
      console.log(result);
      console.log(thisState.items);
    }, function(err) {
      console.log(err);
    });

    // var p1 = new Promise(function(resolve, reject) {
    //   resolve("Success!");
    //   // or
    //   // reject ("Error!");
    // });

    // p1.then(function(value) {
    //   console.log(value); // Success!
    // }, function(reason) {
    //   console.log(reason); // Error!
    // });
  }
}
