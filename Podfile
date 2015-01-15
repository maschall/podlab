workspace 'PodLab.xcworkspace'

xcodeproj 'PodLab/PodLab.xcodeproj/'

def shared_pods
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :ios do
  platform :ios, '8.0'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitteriOS'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  link_with 'PodLabCommoniOS'
  xcodeproj 'PodLab/PodLab.xcodeproj/'
  link_with 'PodLab'
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  link_with 'iTunesSearchiOS'
  
  shared_pods
end

target :osx do
  platform :osx, '10.10'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitterOSX'
  #xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  #link_with 'PodLabCommonOSX'
  #xcodeproj 'PodLab/PodLab.xcodeproj/'
  #link_with 'PodLab'
  #xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  #link_with 'iTunesSearchOSX'
  
  shared_pods
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

