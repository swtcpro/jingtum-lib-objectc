Pod::Spec.new do |s|
  s.name         = "jingtum-lib-objectc"
  s.version      = "1.0.6"
  s.summary      = "jingtum-lib to be used for interacting with jingtum blockchain network。This is the objective-c version。"
  s.description  = "jingtum-lib to be used for interacting with jingtum blockchain network。This is the objective-c version。"
  s.homepage     = "https://github.com/swtcpro/jingtum-lib-objectc"
  s.license= { :type => "MIT", :file => "LICENSE" }
  s.author       = { "jerry" => "xutom2006@126.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/swtcpro/jingtum-lib-objectc.git", :tag => s.version }
  s.source_files = "WebSocketClient/jingtum-lib/*.{h,m}", "WebSocketClient/WebSocket/*.{h,m}"
  s.ios.deployment_target = '10.0'
  s.frameworks   = 'UIKit'
  s.requires_arc = true
  s.dependency 'CoreBitcoin'
  s.dependency 'OpenSSL-Universal', '1.0.1.16'
  s.dependency 'ISO8601DateFormatter'
  s.dependency 'SocketRocket'
end
