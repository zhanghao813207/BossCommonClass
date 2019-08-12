//
//  UIViewController+StoryBoard.m
//  BossWalletCommon
//
//  Created by 高炀辉 on 2019/4/17.
//

#import "UIViewController+StoryBoard.h"
//#import ""

@implementation UIViewController (StoryBoard)

+ (id )storyBoardCreateViewControllerWithBundle: (nonnull NSString *)bundleName StoryBoardName: (nonnull NSString *)storyBoardName{
    NSBundle *baseBundle = [NSBundle bundleForClass:self];
    
    NSURL *bundleUrl = [baseBundle URLForResource:bundleName withExtension:@"bundle"];
    if(!bundleUrl){
        return [[UIViewController alloc] init];
    }
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:storyBoardName bundle:bundle];
    if(!storyBoard){
        return [[UIViewController alloc] init];
    }
    
    return [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
}
@end
