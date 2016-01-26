Pod::Spec.new do |spec|
	spec.name = 'ISRadioButton'
	spec.version = '1.0.'
	spec.summary = 'Radio button written in Swift.'
	spec.homepage = 'https://github.com/hash3r/ISRadioButton'
	spec.license = 'MIT'
	spec.author = { 'Vlad Gnatiuk' => 'hash33r@gmail.com' }
	spec.social_media_url = 'https://twitter.com/glenyi'
	spec.source = { :git => 'https://github.com/hash3r/ISRadioButton.git', :tag => "#{spec.version}" }
	spec.source_files = 'ISRadioButton.swift'
	spec.requires_arc = true
end