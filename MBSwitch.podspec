Pod::Spec.new do |s|
    # s.versionで指定したバージョンを、s.sourceの　:tag　で呼び出すように書いておく.
    s.version = "1.0.0"
    s.source  = { :git => "https://github.com/MMizogaki/MBSwitch.git", :tag => "#{s.version}" }
end