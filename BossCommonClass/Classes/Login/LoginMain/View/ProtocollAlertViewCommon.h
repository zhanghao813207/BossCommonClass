//
//  ProtocollAlertViewCommon.h
//  AFNetworking
//
//  Created by yjs on 2019/8/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtocollAlertViewCommon : UIView

typedef void(^AgreectionBlock)(void);
typedef void(^SoftProtocolActionBlock)(void);
typedef void(^PrivacyProtocolActionBlock)(void);

@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@property (strong,nonatomic)AgreectionBlock agreeBlock;
@property (strong,nonatomic)SoftProtocolActionBlock softBlock;
@property (strong,nonatomic)PrivacyProtocolActionBlock privacyBlock;
@property (weak, nonatomic) IBOutlet UIView *protocolBgView;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *disagreeBtn;

@end

NS_ASSUME_NONNULL_END
