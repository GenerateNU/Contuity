platform :ios, '12.0'
use_frameworks!

def common_pods
  pod 'SwiftLint', '0.27.0'
  pod 'SQLite.swift', '0.11.5'
end

def common_test_pods
end

target 'Contuity' do
  common_pods
end

target 'ContuityTests' do
  common_pods
  common_test_pods
end
