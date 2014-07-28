Kernel.load 'lib/yamazaki/version.rb'

Gem::Specification.new { |s|
	s.name          = 'yamazaki'
	s.version       = Yamazaki.version
	s.author        = 'hydride0'
	s.email         = ''
	s.homepage      = 'https://github.com/hydride0/yamazaki'
	s.platform      = Gem::Platform::RUBY
	s.summary       = 'Moe doesn\'t exist in the 3D form!'
	s.description   = 'Your favourite anime manager'
	s.files         = Dir.glob('lib/**/*')
	s.require_path  = 'lib'
	s.executables   = 'yam'
	s.has_rdoc      = false
	s.licenses      = 'WTFPL'
}
