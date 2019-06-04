//
//  AnnouncementCell.h
//  即时通讯界面
//
//  Created by admin on 2019/4/11.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnnoucementList;
NS_ASSUME_NONNULL_BEGIN

@interface AnnouncementCell : UITableViewCell

/**
 数据
 */
@property(nonatomic, strong)AnnoucementList *model;
@end

NS_ASSUME_NONNULL_END
