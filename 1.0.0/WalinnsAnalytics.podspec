Pod::Spec.new do |s|
s.name              = 'WalinnsAnalytics'
s.version           = '1.0.0'
s.summary           = 'A really cool SDK for mobile analytics.'
s.homepage          = 'https://github.com/Rejoylin/WalinnsObjecetiveC'

s.author            = { 'Name' => 'rejoylin2015@gmail.com' }
s.license           = { :type => 'MIT', :file => 'LICENSE' }

s.platform          = :ios
s.source            = { :git => 'https://github.com/Rejoylin/WalinnsObjecetiveC.git' }

s.ios.deployment_target = '8.0'
s.ios.vendored_frameworks = 'WalinnsAnalytics.framework'
end


