//
//  LoanRepaymentAttachmentModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 借款/还款审批单附件
 */
@interface LoanRepaymentAttachmentModel : NSObject

/**
 附件名称
 */
@property (nonatomic, strong) NSString *file_name;

/**
 附件url
 */
@property (nonatomic, strong) NSString *file_url;

@end

NS_ASSUME_NONNULL_END
