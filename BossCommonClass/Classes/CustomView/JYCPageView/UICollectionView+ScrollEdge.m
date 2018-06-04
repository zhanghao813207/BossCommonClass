//
//  UICollectionView+ScrollEdge.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/3/11.
//

#import "UICollectionView+ScrollEdge.h"

@implementation UICollectionView (ScrollEdge)

// 为了解决在视图的最后一个view上放置tabelView  tableView右滑删除手势冲突的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStatePossible){
        return YES;
    } else {
        return NO;
    }
}

@end
