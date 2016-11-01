# SwiftFlipLoading
An simple loading view with flip image in Swift

# Installation
1. Just add `SwiftFlipLoading.swift` file to your project (`SwiftFlipLoading/SwiftFlipLoading.swift`).


# Preview
![Preview ](https://raw.githubusercontent.com/SeptiyanAndika/SwiftFlipLoading/master/preview/flipview.gif)

# Setup
The SwiftFlipLoading initialization

  var loadingView:SwiftFlipLoading?;

	self.loadingView = SwiftFlipLoading(images: ["1","2","3","4"]);

Show loadingView.

	 self.loadingView?.showLoading(parentView: self.view);

Stop loadingView.

   self.loadingView?.stopLoading()


## License

SwiftFlipLoading is available under the MIT license. See the LICENSE file for more info.
