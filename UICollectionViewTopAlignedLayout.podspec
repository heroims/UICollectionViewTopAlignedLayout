Pod::Spec.new do |s|
s.name                  = 'UICollectionViewTopAlignedLayout'
s.version               = '1.0'
s.summary               = ' A layout for UICollectionView that aligns the cells to the top. '
s.homepage              = 'https://github.com/heroims/UICollectionViewTopAlignedLayout'
s.license               = { :type => 'MIT', :file => 'README.md' }
s.author                = { 'heroims' => 'heroims@163.com' }
s.source                = { :git => 'https://github.com/heroims/UICollectionViewTopAlignedLayout.git', :tag => "#{s.version}" }
s.platform              = :ios, '6.0'
s.source_files          = 'UICollectionViewTopAlignedLayout/*.{h,m}'
s.requires_arc          = true
end

