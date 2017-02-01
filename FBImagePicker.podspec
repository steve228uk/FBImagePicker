Pod::Spec.new do |s|

  s.name         = "FBImagePicker"
  s.version      = "1.0.0"
  s.summary      = ":camera: An image picker for Facebook"
  s.description  = <<-DESC
  FBImagePicker is a quick and easy drop-in image picker for Facebook. It works in tandem with the official Facebook SDK to allow easy selection of images from user albums.
                   DESC

  s.homepage     = "https://github.com/steve228uk/FBImagePicker"
  s.license      = "MIT"


  s.author             = { "Stephen Radford" => "steve228uk@gmail.com" }
  s.social_media_url   = "http://twitter.com/steve228uk"


  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/steve228uk/FBImagePicker.git", :tag => "1.0.0" }
  s.source_files  = "Classes/**/*.swift"
  s.framework = "UIKit"
  s.resource_bundles = {
      'FBImagePicker' => ['Resources/**/*.{storyboard}']
  }

  s.dependency "Alamofire"
  s.dependency "FBSDKCoreKit"
  s.dependency "FBSDKLoginKit"

end
