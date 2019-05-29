//
//  UITableView+EmptyData.h
//  BossCommonClass
//
//  Created by admin on 2019/4/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (EmptyData)

/**
 没有数据tableview显示的内容

 @param message 信息提示
 @param imgName 图片名字
 @param rowCount cell的个数
 */
- (void) tableViewDisplayWitMsg:(NSString *)message imageName:(NSString *)imgName ifNecessaryForRowCount:(NSUInteger) rowCount;
@end

NS_ASSUME_NONNULL_END
