#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "RHMarkdownLabel"
  s.version          = "0.0.1"
  s.summary          = "RHMarkdownLabel is a UILabel replacement that supports markdown."
  s.homepage         = "https://github.com/chriscdn/RHMarkdownLabel"
  s.license          = 'MIT'
  s.author           = { "Christopher Meyer" => "chris@schwiiz.org" }
  s.source           = { :git => "https://github.com/chriscdn/RHMarkdownLabel.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/chriscdn'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'RHMarkdownLabel/*'

  s.dependency 'TTTAttributedLabel'
  s.dependency 'XNGMarkdownParser'

end