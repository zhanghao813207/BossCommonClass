//
//  NSMutableArray+SelectType.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/18.
//

#import "NSMutableArray+SelectType.h"

@implementation NSMutableArray (SelectType)

-(int)returnSelectType{
    
    if ([self containsObject:[NSNumber numberWithInt:0]] && [self containsObject:[NSNumber numberWithInt:1]]) {
        // 包含0 并且 包含1
        return 2;
        
    } else if ([self containsObject:[NSNumber numberWithInt:0]] && ![self containsObject:[NSNumber numberWithInt:1]]){
        
        return 0;
        
    } else if(![self containsObject:[NSNumber numberWithInt:0]] && [self containsObject:[NSNumber numberWithInt:1]]){
        
        return 1;
        
    } else {
        
        return 0;
    }
}

@end
