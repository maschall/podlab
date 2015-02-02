workspace 'PodLab.xcworkspace'

xcodeproj 'iOSApp/iOSApp.xcodeproj/'

def shared_pods
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire'
end

target :PodSplitteriOS do
  platform :ios, '8.0'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  shared_pods
end

target :PodSplitterOSX do
  platform :osx, '10.10'
  xcodeproj 'PodSplitter/PodSplitter.xcodeproj/'
  shared_pods
end

target :PodLabCommoniOS do
  platform :ios, '8.0'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  shared_pods
end

target :PodLabCommonOSX do
  platform :osx, '10.10'
  xcodeproj 'PodLabCommon/PodLabCommon.xcodeproj/'
  shared_pods
end

target :iTunesSearchiOS do
  platform :ios, '8.0'
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  shared_pods
end

target :iTunesSearchOSX do
  platform :osx, '10.10'
  xcodeproj 'iTunesSearch/iTunesSearch.xcodeproj/'
  shared_pods
end

target :iOSApp do
  platform :ios, '8.0'
  xcodeproj 'iOSApp/iOSApp.xcodeproj/'
  shared_pods
end

target :OSXApp do
  platform :osx, '10.10'
  xcodeproj 'OSXApp/OSXApp.xcodeproj/'
  shared_pods
end

