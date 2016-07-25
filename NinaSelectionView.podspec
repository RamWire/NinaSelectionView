Pod::Spec.new do |s|
s.name     = 'NinaSelectionView'
s.version  = '0.1.0'
s.license  = 'MIT'
s.platform      = :ios, '7.0'
s.summary  = 'A dramatic way to select your buttons by NinaSelectionView.'
s.homepage = 'https://github.com/RamWire/NinaSelectionView'
s.author   = { 'RamWire' => 'RamWire' }
s.source   = { :git => 'https://github.com/RamWire/NinaSelectionView.git', :tag => s.version.to_s }
s.source_files = 'NinaSelectionView/**/*.{h,m}'
s.framework = 'UIKit'
s.requires_arc  = true
end