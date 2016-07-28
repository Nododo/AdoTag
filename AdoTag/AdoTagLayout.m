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
    self.tagAlignment = self.tagAlignment?: AdoTagAlignmentLeft;
//    self.tagAlignment = AdoTagAlignmentRight; //test alignmentRight
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
        switch (self.tagAlignment) {
            case AdoTagAlignmentLeft:
                tempFrame.origin.x =  self.sectionInset.left;
                break;
            case AdoTagAlignmentRight:
                tempFrame.origin.x = CGRectGetWidth(self.collectionView.frame) - CGRectGetWidth(tempFrame) - self.sectionInset.right;;//alignmentRight   origin should go right
                break;
            default:
                break;
        }
        currentAttributes.frame = tempFrame;
        return currentAttributes;
    }
    
    NSIndexPath *lastPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    UICollectionViewLayoutAttributes *lastAttributes = [self layoutAttributesForItemAtIndexPath:lastPath];
    CGRect currentFrame = currentAttributes.frame;
    CGRect lastFrame = lastAttributes.frame;
    
    CGRect currentRowFrame = CGRectMake(self.sectionInset.left, currentFrame.origin.y, layoutWidth, currentFrame.size.height);
    if (!CGRectIntersectsRect(lastFrame, currentRowFrame)) {
        switch (self.tagAlignment) {
            case AdoTagAlignmentLeft:
                currentFrame.origin.x =  self.sectionInset.left;
                break;
            case AdoTagAlignmentRight:
                currentFrame.origin.x = CGRectGetWidth(self.collectionView.frame) - CGRectGetWidth(currentFrame) - self.sectionInset.right;
                break;
            default:
                break;
        }
        currentAttributes.frame = currentFrame;
        return currentAttributes;
    }
    
    switch (self.tagAlignment) {
        case AdoTagAlignmentLeft:
            currentFrame.origin.x = CGRectGetMaxX(lastFrame) + self.minimumLineSpacing;
            break;
        case AdoTagAlignmentRight:
            currentFrame.origin.x = CGRectGetMinX(lastFrame) - self.minimumLineSpacing - CGRectGetWidth(currentFrame);//should calculate the current orign by lastFrame left
            break;
        default:
            break;
    }
    currentAttributes.frame = currentFrame;
    return currentAttributes;
}

@end
