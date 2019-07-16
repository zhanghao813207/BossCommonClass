//
//  WebExtraDataModel.m
//  BossOwner
//
//  Created by yjs on 2019/7/5.
//  Copyright © 2019 高炀辉. All rights reserved.
//

#import "WebExtraDataModel.h"

@implementation WebExtraDataModel

NSString *const kmessageSessionsModelTeam_id= @"team_id";


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if(![dictionary[kmessageSessionsModelTeam_id] isKindOfClass:[NSNull class]]){
        self.team_id = dictionary[kmessageSessionsModelTeam_id];
    }

    
    return self;
}

-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
  
    if(self.team_id != nil){
        dictionary[kmessageSessionsModelTeam_id] = self.team_id;
    }
    
    return dictionary;
    
}

@end
