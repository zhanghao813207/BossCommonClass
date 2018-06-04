//
//  UIView+ChangeScope.m
//  Gtyk
//
//  Created by 贾远潮 on 2017/3/16.
//  Copyright © 2017年 GTYK. All rights reserved.
//

#import "UIView+ChangeScope.h"
#import <objc/runtime.h>
@implementation UIView (ChangeScope)

static char *changeScopeKey;

- (void)setChangeScope:(NSString *)changeScope
{
    objc_setAssociatedObject(self, &changeScopeKey, changeScope, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)changeScope
{
    return objc_getAssociatedObject(self, &changeScopeKey);
}

- (void)changeViewScope:(UIEdgeInsets)changeInsets
{
    self.changeScope = NSStringFromUIEdgeInsets(changeInsets);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets changeInsets = UIEdgeInsetsFromString(self.changeScope);
    if (changeInsets.left != 0 || changeInsets.top != 0 || changeInsets.right != 0 || changeInsets.bottom != 0) {
        CGRect myBounds = self.bounds;
        myBounds.origin.x = myBounds.origin.x + changeInsets.left;
        myBounds.origin.y = myBounds.origin.y + changeInsets.top;
        myBounds.size.width = myBounds.size.width - changeInsets.left - changeInsets.right;
        myBounds.size.height = myBounds.size.height - changeInsets.top - changeInsets.bottom;
        return CGRectContainsPoint(myBounds, point);
    } else {
        return CGRectContainsPoint(self.bounds,point);
    }
}

@end
