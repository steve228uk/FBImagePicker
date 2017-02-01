# FBImagePicker
### A simple drop-in image picker for Facebook

![Facebook Image Picker for iOS](https://github.com/steve228uk/FBImagePicker/blob/master/Screenshots/example.gif)

## Installation

### CocoaPods

Simply add the following dependency to your `podfile`

```ruby
pod 'FBImagePicker', '~> 1.0'
```

### Usage

> This usage example assumes that you've already setup the [Facebook SDK for iOS](https://developers.facebook.com/docs/ios/)

## 1. Set the delegate

First, set the delegate where you wish to access selected images:

```swift
import FBImagePicker

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		FBImagePicker.delegate = self
	}

	func fbImagePicker(imageSelected image: UIImage?) {
		print("Image selected")
	}

}
```

## 2. Present the picker

Next, present the picker from a view controller using the following method:

```swift
FBImagePicker.present(on: self)
```

## 3. Configure the picker (Optional)

By default FBImagePicker is designed as a quick drop-in but there are a number of options that can be configured if you like to get into the nitty-gritty.

The following options are available with their defaults on `FBImagePicker.Settings`.

```swift
/// This is the title that's displayed in the navigation bar on the album selection screen
static var albumsTitle = "Facebook Albums"
```

```swift
/// This is the text that's displayed for the empty state in the album selection screen
static var noAlbumsText = "No Albums"
```

```swift
/// This is the text that's displayed for the empty state in the album selection screen
static var noImagesText = "No Images"
```

```swift
/// The style the status bar should be in the image picker
static var statusBarStyle = UIStatusBarStyle.lightContent
```

```swift
/// This is the tint colour used for buttons on the nav bar
static var navTintColor = UIColor.white
```

```swift
/// The tint colour of the background of the nav bar
static var navBarTintColor = UIColor(hue:0.61, saturation:0.60, brightness:0.59, alpha:1.00)
```

```swift
/// This is the text colour of the title in the nav bar
static var navBarTextColor = UIColor.white
```

```swift
/// Used to control the cross fade on images. Leave as 0 for no transition.
static var imageTransitionDuration = 0.0
```

```swift
/// This controls the offset of the infinite scroll. If you're not sure, leave this as 200.
static var infiniteScrollOffset: CGFloat = 200
```
