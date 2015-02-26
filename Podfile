workspace 'PodLab.xcworkspace'
use_frameworks!

xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
xcodeproj 'iOSApp/iOSApp.xcodeproj/'
xcodeproj 'OSXApp/OSXApp.xcodeproj/'

target :iOS do
  use_frameworks!
  platform :ios, '8.0'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitteriOS'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  link_with 'PodLabCommoniOS'
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  link_with 'iTunesSearchiOS'
  xcodeproj 'iOSApp/iOSApp.xcodeproj/'
  link_with 'iOSApp'
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :OSX do
  use_frameworks!
  platform :osx, '10.10'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  link_with 'PodSplitterOSX'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  link_with 'PodLabCommonOSX'
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  link_with 'iTunesSearchOSX'
  xcodeproj 'OSXApp/OSXApp.xcodeproj/'
  link_with 'OSXApp'
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end