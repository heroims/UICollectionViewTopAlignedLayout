//
//  ViewController.m
//  Example
//
//  Created by Zhao Yiqi on 2017/4/1.
//  Copyright © 2017年 Zhao Yiqi. All rights reserved.
//

#import "ViewController.h"

#import "UICollectionViewTopAlignedLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateTopAlignedLayout>{
    NSMutableArray *_sizeArray;
}

@end

@implementation ViewController

static NSString * const CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *tmp=@[@(100),@(180),@(80),@(60)];
    _sizeArray=[[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<20; i++) {
        [_sizeArray addObject:[NSValue valueWithCGSize:CGSizeMake([tmp[arc4random()%4] floatValue], [tmp[arc4random()%4] floatValue])]];
    }
    
    UICollectionViewTopAlignedLayout *layout=[[UICollectionViewTopAlignedLayout alloc] init];
    layout.minimumLineSpacing=10;
    layout.minimumInteritemSpacing=10;

    UICollectionView *tmpView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    tmpView.backgroundColor=[UIColor whiteColor];
    tmpView.dataSource=self;
    tmpView.delegate=self;
    [tmpView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [self.view addSubview:tmpView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _sizeArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%255/255. green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1];
    return cell;
}

#pragma mark - UICollectionViewDelegateTopAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_sizeArray[indexPath.item] CGSizeValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 15 : 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
