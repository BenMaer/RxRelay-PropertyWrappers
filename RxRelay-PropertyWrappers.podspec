#
# Be sure to run `pod lib lint RxRelay-PropertyWrappers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxRelay-PropertyWrappers'
  s.version          = '0.2.1'
  s.summary          = 'Offers convenient property wrappers for relays from RXRelay.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Offers convenient property wrappers for relays from RXRelay, in particular where a type wants to publicly offer just an Observable or AnyObserver, while keeping its own private reference to the underlying relay.
                       DESC

  s.homepage         = 'https://github.com/BenMaer/RxRelay-PropertyWrappers'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ben Maer' => 'ben@resplendent.co' }
  s.source           = { :git => 'https://github.com/BenMaer/RxRelay-PropertyWrappers.git', :tag => "v#{s.version}" }

  s.ios.deployment_target = '9.3'
  s.swift_version = '4.0'

  s.source_files = 'RxRelay-PropertyWrappers/Classes/**/*'
  
  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'Example/Tests/**/*.swift'
  end
  
   s.dependency 'RxRelay', '6.9.0'
end
