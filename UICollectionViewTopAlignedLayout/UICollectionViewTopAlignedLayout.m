//
//  UICollectionViewTopAlignedLayout.m
//  xgoods
//
//  Created by admin on 2017/3/28.
//  Copyright © 2017年 Look. All rights reserved.
//

#import "UICollectionViewTopAlignedLayout.h"

@interface UICollectionViewLayoutAttributes (TopAligned)

@end

@implementation UICollectionViewLayoutAttributes (TopAligned)

- (void)topAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset
{
    CGRect frame = self.frame;
    frame.origin.y = sectionInset.top;
    self.frame = frame;
}

@end

@interface UICollectionViewTopAlignedLayout (){
    NSInteger _lastFirstItemInRow;
    NSInteger _lastFirstItemInSection;

}

@end

@implementation UICollectionViewTopAlignedLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];
    
    BOOL isFirstItemInSection = indexPath.item == 0;
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    
    if (isFirstItemInSection) {
        [currentItemAttributes topAlignFrameWithSectionInset:sectionInset];
        _lastFirstItemInSection=indexPath.section;
        _lastFirstItemInRow=0;
        return currentItemAttributes;
    }
    
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;

    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                              currentFrame.origin.y,
                                              layoutWidth,
                                              currentFrame.size.height);
    // if the current frame, once left aligned to the left and stretched to the full collection view
    // widht intersects the previous frame then they are on the same line
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);
    
    if (isFirstItemInRow) {

        NSInteger previousIndexPathSection=indexPath.section;
        if (_lastFirstItemInRow==0) {
            previousIndexPathSection=_lastFirstItemInSection;
        }
        CGFloat previousY=0;
        for (NSInteger i=_lastFirstItemInRow; i<indexPath.item; i++) {
            NSIndexPath *tmpPreviousIndexPath=[NSIndexPath indexPathForItem:i inSection:previousIndexPathSection];
            CGRect tmpPreviousFrame = [self layoutAttributesForItemAtIndexPath:tmpPreviousIndexPath].frame;
            previousY=(previousY<(tmpPreviousFrame.origin.y+tmpPreviousFrame.size.height))?(tmpPreviousFrame.origin.y+tmpPreviousFrame.size.height):previousY;
        }
        
        _lastFirstItemInRow=indexPath.item;
        
        CGRect frame = currentItemAttributes.frame;
        frame.origin.y = previousY;
        currentItemAttributes.frame = frame;

        // make sure the first item on a line is left aligned
        return currentItemAttributes;
    }
    
    CGRect frame = currentItemAttributes.frame;
    CGFloat tmpMinimumInteritemSpacing=[self evaluatedMinimumInteritemSpacingForItemAtIndex:indexPath.row];
    frame.origin.x = previousFrameRightPoint + tmpMinimumInteritemSpacing;
    frame.origin.y = previousFrame.origin.y;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}


- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateTopAlignedLayout> delegate = (id<UICollectionViewDelegateTopAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:index];
    } else {
        return self.minimumInteritemSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateTopAlignedLayout> delegate = (id<UICollectionViewDelegateTopAlignedLayout>)self.collectionView.delegate;
        
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}

@end
