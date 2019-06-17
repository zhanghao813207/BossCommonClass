//
//  SelectContactCell.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import <UIKit/UIKit.h>
#import "BizDistrictTeam.h"

NS_ASSUME_NONNULL_BEGIN
/// CellType 定义
typedef enum : NSUInteger {
    /// 内容类型: 不显示左侧选中框
    contentCell,
    /// 编辑类型: 显示左侧选中框
    editCell
} cellType;

typedef void(^selectStatus)(BOOL selectStatus);

@interface SelectContactCell : UITableViewCell
/// 是否选中状态ImageView
@property (weak, nonatomic) IBOutlet UIImageView *selectStatusImageView;
/// 头像ImageView
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/// 名字Label
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// Cell的类型
@property (nonatomic, assign) cellType celltype;
/// 距离左边的距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SelectIconLeftConstranint;

@property (nonatomic, copy) selectStatus selectBlock;


@property (nonatomic, strong) BizDistrictTeam * model;
@end

NS_ASSUME_NONNULL_END
