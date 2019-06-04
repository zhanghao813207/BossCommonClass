//
//  InputCell.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <UIKit/UIKit.h>
#import "InputMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

/**
 Cell操作代理
 */
@protocol InputCellDelegate <NSObject>

/**
 Cell编辑完成回调

 @param content 编辑内容
 @param type Cell信息Model
 */
- (void)inputContent:(NSString *)content type:(InputMessageModel *)type;

/**
 Cell点击回调

 @param model Cell信息Model
 */
- (void)arrowActionWithModel:(InputMessageModel *)model;
@end

/**
 推荐信息Cell
 */
@interface InputCell : UITableViewCell

/**
 Cell信息Model
 */
@property(nonatomic, strong)InputMessageModel *model;

/**
 Cell操作代理
 */
@property(nonatomic,weak)id<InputCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
