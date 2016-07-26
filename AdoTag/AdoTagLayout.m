//
//  AdoTagLayout.m
//  CollectionView
//
//  Created by 杜维欣 on 16/7/22.
//  Copyright © 2016年 Nododo. All rights reserved.
//

#import "AdoTagLayout.h"

static CGFloat const topPadding  = 10;
static CGFloat const leftPadding = 20;



@implementation AdoTagLayout


- (void)prepareLayout {
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(topPadding, leftPadding, topPadding, leftPadding);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *atttibutes in attributesArray) {
        atttibutes.frame = [self layoutAttributesForItemAtIndexPath:atttibutes.indexPath].frame;
    }
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right;
    if (indexPath.item == 0) {
        CGRect tempFrame = currentAttributes.frame;
        tempFrame.origin.x = self.sectionInset.left;
        currentAttributes.frame = tempFrame;
        return currentAttributes;
    }
    
    NSIndexPath *lastPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *lastAttributes = [self layoutAttributesForItemAtIndexPath:lastPath];
    CGRect currentFrame = currentAttributes.frame;
    CGRect lastFrame = lastAttributes.frame;
    
    //    NSLog(@"currentFrame = %@ lastFrame = %@",NSStringFromCGRect(currentFrame), NSStringFromCGRect(lastFrame));
    CGRect currentRowFrame = CGRectMake(self.sectionInset.left, currentFrame.origin.y, layoutWidth, currentFrame.size.height);
    if (!CGRectIntersectsRect(lastFrame, currentRowFrame)) {
        currentFrame.origin.x = self.sectionInset.left;
        currentAttributes.frame = currentFrame;
        return currentAttributes;
    }
    
    
    currentFrame.origin.x = CGRectGetMaxX(lastFrame) + self.minimumLineSpacing;//坑过 minimumLineSpacing 我
    currentAttributes.frame = currentFrame;
    
    return currentAttributes;
}

@end
