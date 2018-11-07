//
//  CJCollecitonViewFlowLayout.m
//  CJModule
//
//  Created by 仁和Mac on 2017/6/27.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJCollecitonViewFlowLayout.h"

@implementation CJCollecitonViewFlowLayout

-(void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0.f;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/// 自动调用，其调用频率受-shouldInvalidateLayoutForBoundsChange影响。
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrAry = @[].mutableCopy;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0,j =  count; i < j; i++) {

        UICollectionViewLayoutAttributes *attr =  [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [attrAry addObject:attr];

    }
    return attrAry;
}

/// 必须手动调用
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGFloat offset = self.collectionView.contentOffset.x;
    NSInteger leftVisibleItem = ceil(offset/self.itemSize.width);
    if (indexPath.row >= leftVisibleItem) {
        attr.frame = CGRectMake(offset, 0, self.itemSize.width, self.itemSize.height);
    }
    attr.zIndex = 100 - indexPath.row;
    return attr;
}

/// 拖动的一瞬间开始调用,proposedContentOffset表示预计停留的位置，velocity表示速率。
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint rawPoint = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    /*
    NSInteger leftVisibleItem = ceil(proposedContentOffset.x / self.itemSize.width);
    leftVisibleItem--;
    CGFloat leftVisibleItemMargin = leftVisibleItem * self.itemSize.width - proposedContentOffset.x;
    if (leftVisibleItemMargin < self.collectionView.frame.size.width/2) {
        rawPoint.x = leftVisibleItem * self.itemSize.width;
    }*/
    return rawPoint;
}

#pragma mark --- 不会调用的方法
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset];
}



@end
