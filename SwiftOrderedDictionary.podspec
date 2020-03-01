#
#  Be sure to run `pod spec lint OrderedDictionary.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "SwiftOrderedDictionary"
  spec.version      = "1.0.0"
  spec.summary      = "An implementation of a Swift Ordered Dictionary"

  spec.description  = <<-DESC
  A version of the standard Swift Dictionary class that remembers te order in which items were added.  Sticks as close as possible to the Dictionary API, so it should be usable as a drop-in replacement.
                   DESC

  spec.homepage     = "https://github.com/jdstmporter/OrderedDictionary.git"
  
  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => "BSD", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "julian porter" => "julian@porternet.org.uk" }
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

   spec.swift_version = "5.0"
   spec.ios.deployment_target = "13.0"
   spec.osx.deployment_target = "10.10"
  


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  spec.source       = { :git => "https://github.com/jdstmporter/OrderedDictionary.git", :tag => "#{spec.version}" }

  spec.source_files  = "src/*.{swift}"
  
  spec.test_spec do |test_spec|
      test_spec.source_files = "Tests/*.{swift}"
      test_spec.frameworks = "XCTest"
      end
  


end
