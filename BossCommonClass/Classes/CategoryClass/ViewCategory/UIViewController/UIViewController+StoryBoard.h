//
//  UIViewController+StoryBoard.h
//  BossWalletCommon
//
//  Created by 高炀辉 on 2019/4/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (StoryBoard)


/**
 通过 StoryBoard 加载控制器

 @param bundleName bundle名称
 @param storyBoardName storyBoard名称
 @return UIViewController
 */
+ (UIViewController *)storyBoardCreateViewControllerWithBundle: (nonnull NSString *)bundleName StoryBoardName: (nonnull NSString *)storyBoardName;
@end

NS_ASSUME_NONNULL_END
