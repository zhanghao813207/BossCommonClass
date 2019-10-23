//
//  AnnouncementCell.h
//  即时通讯界面
//
//  Created by admin on 2019/4/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BossBasicDefine.h"

@class AnnoucementList;
NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementCell : UITableViewCell

/**
 数据
 */
@property(nonatomic, strong)AnnoucementList *model;
/**
 数据类型 公众号 or 普通公告
 */
@property(nonatomic, assign)MessageListType type;
@end

NS_ASSUME_NONNULL_END
