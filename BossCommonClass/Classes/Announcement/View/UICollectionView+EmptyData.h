//
//  UICollectionView+EmptyData.h
//  AFNetworking
//
//  Created by 易庆萍 on 2020/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (EmptyData)

/**
 没有数据tableview显示的内容

 @param message 信息提示
 @param imgName 图片名字
 @param rowCount cell的个数
 */
- (void)collectionViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger)rowCount;
@end

NS_ASSUME_NONNULL_END
