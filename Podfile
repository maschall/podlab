platform :ios, '8.0'
workspace 'PodLab.xcworkspace'

xcodeproj 'PodLab/PodLab.xcodeproj/'
xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'

target :application do
  xcodeproj 'PodLab/PodLab.xcodeproj/'
  link_with 'PodLab'
  
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :common do
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitteriOS'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  link_with 'PodLabCommoniOS'
  
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :itunes do
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  link_with 'iTunesSearchiOS'
  
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :unit_tests do
  xcodeproj 'PodLab/PodLab.xcodeproj/'
  link_with 'PodLabTests'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitterTests'
  
  pod 'Quick', :git => 'https://github.com/Quick/Quick'
  pod 'Nimble', :git => 'https://github.com/Quick/Nimble'
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

