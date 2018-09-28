//
//  EventExtraModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "EventExtraModel.h"
#import "BossOaExamineRequest.h"

@interface EventExtraModel()
#pragma mark -- boss助理 --- boss 通知 --- start
/**
 审批单信息
 */
@property (nonatomic, strong) ExamineOrderModel *examineOrderInfo;

/**
 审批记录信息
 */
@property (nonatomic, strong) ExamineFlowRecordModel *flowRecordInfo;

/**
 催办记录信息
 */
@property (nonatomic, strong) ApplicationUrgeRecordModel *urgeRecordInfo;

@property (nonatomic, assign) BOOL orderInfoResponse;

@property (nonatomic, assign) BOOL urgeRecordInfoResponse;

@property (nonatomic, assign) BOOL loadError;

#pragma mark -- boss助理 --- boss 通知 --- end

@end

@implementation EventExtraModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"oa_application_order_id"]) {
        if (!value || value == [NSNull null]) {
            self.orderInfoResponse = YES;
            [self updateDate];
            return;
        }
        self.oa_application_order_id = value ? [NSString stringWithFormat:@"%@",value] : nil;
        if (!self.oa_application_order_id) {
            self.orderInfoResponse = YES;
            [self updateDate];
            return;
        }
        return;
    }

    if ([key isEqualToString:@"oa_urge_record_id"]) {
        if (!value || value == [NSNull null]) {
            self.urgeRecordInfoResponse = YES;
            [self updateDate];
            return;
        }
        self.oa_urge_record_id = value ? [NSString stringWithFormat:@"%@",value] : nil;
        if (!self.oa_urge_record_id) {
            self.urgeRecordInfoResponse = YES;
            [self updateDate];
            return;
        }
        return;
    }

    if (!value || value == [NSNull null]) {
        return;
    }
        
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)reloadDate
{
    self.loadError = NO;
    if (self.oa_urge_record_id) {
        WS(weakSelf);
        self.needUrgeInfo = YES;
        [BossOaExamineRequest OaExamineRequestGetUrgeDetailWithUrgeId:self.oa_urge_record_id orderRecordId:self.oa_application_order_id?:@"" success:^(ApplicationUrgeRecordModel *urgeRecordModel) {
            weakSelf.urgeRecordInfo = urgeRecordModel;
            weakSelf.examineOrderInfo = urgeRecordModel.application_order_info;
            weakSelf.flowRecordInfo = urgeRecordModel.flow_record_info;
            weakSelf.orderInfoResponse = YES;
            weakSelf.urgeRecordInfoResponse = YES;
            [weakSelf updateDate];
        } fail:^(id error) {
            weakSelf.urgeRecordInfoResponse = YES;
            [weakSelf updateDateError];
        }];
        return;
    }
    if (self.oa_application_order_id) {
        WS(weakSelf);
        [BossOaExamineRequest OaExamineRequestGetExamineDetailWithExamineId:self.oa_application_order_id showError:NO successBlock:^(ExamineOrderModel *examineFlowModel) {
            weakSelf.orderInfoResponse = YES;
            if (self.oa_application_record_id) {
                NSDictionary *recordDic = [JYCSimpleToolClass changeToDictionaryWithArray:examineFlowModel.flow_record_list byKey:@"_id"];
                self.flowRecordInfo = recordDic[self.oa_application_record_id];
            }
            self.examineOrderInfo = examineFlowModel;
            [weakSelf updateDate];
        } fail:^(id error) {
            weakSelf.orderInfoResponse = YES;
            [weakSelf updateDateError];
        }];
    }
}

- (void)updateDate
{
    if (self.needUrgeInfo && (self.orderInfoResponse && self.urgeRecordInfoResponse)) {
        if (self.dateNeedUpdateBlock) {
            self.dateNeedUpdateBlock(self);
        }
        if (self.footDateNeedUpdateBlock) {
            self.footDateNeedUpdateBlock(self);
        }
    } else if(!self.needUrgeInfo && self.orderInfoResponse) {
        if (self.dateNeedUpdateBlock) {
            self.dateNeedUpdateBlock(self);
        }
        if (self.footDateNeedUpdateBlock) {
            self.footDateNeedUpdateBlock(self);
        }
    }
}

- (void)updateDateError
{
    self.loadError = YES;
    if (self.dateLoadErrorBlock) {
        self.dateLoadErrorBlock();
    }
}

- (ExamineFlowRecordModel *)flowRecordInfo
{
    if (!_flowRecordInfo) {
        if (_oa_application_record_id && _examineOrderInfo) {
            NSDictionary *recordDic = [JYCSimpleToolClass changeToDictionaryWithArray:_examineOrderInfo.flow_record_list byKey:@"_id"];
            _flowRecordInfo = recordDic[self.oa_application_record_id];
        }
    }
    return _flowRecordInfo;

}

@end
