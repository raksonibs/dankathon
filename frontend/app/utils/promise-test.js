export class PromiseTest {
  constructor(test) {
    this.items = [];
  }

  addItem(item) {
    this.items.push(item);
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
