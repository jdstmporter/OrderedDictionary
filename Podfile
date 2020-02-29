use_frameworks!

platform :macos, '10.15'
supports_swift_versions '>= 5'

project './OrderedDictionary.xcodeproj'

target 'Example' do
  pod 'SwiftOrderedDictionary', :path => '.'

  target 'Tests' do
    inherit! :search_paths
    pod 'SwiftOrderedDictionary', :path => '.'
  end
end
