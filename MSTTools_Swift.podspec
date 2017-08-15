#
#  Be sure to run `pod spec lint MSTTools_Swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

  Pod::Spec.new do |s|

  s.name         = "MSTTools_Swift"
  s.version      = "1.0.5"
  s.summary      = "Tools in common use."
  s.description  = <<-DESC
  Tools in common use...
                   DESC

  s.homepage     = "https://github.com/immustard/MSTTools_Swift"
  s.license      = "MIT"
  s.author             = { "Mustard" => "mustard_gxg@foxmail.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/immustard/MSTTools_Swift.git", :tag => "#{s.version}" }

  s.source_files  = "MSTTools_Swift", "MSTTools_Swift/**/*.{swift}"

  s.framework  = "UIKit"

  s.requires_arc = true

  end
