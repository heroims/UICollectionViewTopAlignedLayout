# UICollectionViewTopAlignedLayout
 A layout for UICollectionView that aligns the cells to the top.

![Screenshot1](https://heroims.github.io/UICollectionViewTopAlignedLayout/SimulatorScreenShot1.png "Screenshot1") 


## Usage

Simply set `UICollectionViewTopAlignedLayout` as the layout object for your collection view either via code:

```objc
CGRect frame = ...
UICollectionViewTopAlignedLayout *layout = [UICollectionViewTopAlignedLayout alloc] init];
UICollectionView *topAlignedCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
```

## Installation

### via CocoaPods
Install CocoaPods if you do not have it:-
````
$ [sudo] gem install cocoapods
$ pod setup
````
Create Podfile:-
````
$ edit Podfile
platform :ios, '6.0'


pod 'UICollectionViewTopAlignedLayout',  '~> 1.0'

$ pod install
````
Use the Xcode workspace instead of the project from now on.

