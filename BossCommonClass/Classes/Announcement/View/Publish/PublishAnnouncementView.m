
//
//  PublishAnnouncementView.m
//  AFNetworking
//
//  Created by admin on 2019/4/15.
//

#import "PublishAnnouncementView.h"
#import "JYCMethodDefine.h"
#import "AnnouncementTextView.h"
#import "Masonry.h"
#import "TestBrowserView.h"
#import "AddImageView.h"
#import "UIView+GetVC.h"
#import "UIAlertController+Extension.h"
#import "AddressBookVC.h"
#import "UIView+MJExtension.h"
#import "CameraView.h"
#import "PublishModel.h"
#import "JYCSimpleToolClass.h"
#import "AnnouncementRequest.h"
#import "UIView+ShowView.h"

@interface PublishAnnouncementView ()<UITextViewDelegate,CameraViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,AddImageViewDelegate,AddressBookVCDelegate>

/**
 标题(取消 新建公告 发布)
 */
@property(nonatomic, strong)UIView *headerView;

/**
 取消按钮
 */
@property(nonatomic, strong)UIButton *cancelButton;

/**
 发布按钮
 */
@property(nonatomic, strong)UIButton *publishButton;

/**
 大标题(新建公告)
 */
@property(nonatomic, strong)UILabel *headlineLabel;

/**
 内容(标题 接收人 正文 图片)
 */
@property(nonatomic, strong)UIView *contentView;


/**
 标题
 */
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITextField *titleField;
@property(nonatomic, strong)UIView *lineView;

@property(nonatomic, strong)UIView *containerView;

/**
 接收人
 */
@property(nonatomic, strong)UILabel *receptLabel;
@property(nonatomic, strong)UILabel *selectLabel;
@property(nonatomic, strong)UIView *twoLineView;

/**
 正文
 */
@property(nonatomic, strong)AnnouncementTextView *textView;
@property(nonatomic, strong)UIView *container;
@property(nonatomic, strong)UIScrollView *scrollView;
/**
 图片
 */
@property(nonatomic, strong)AddImageView *addView;

/**
 保存选中的图片
 */
@property(nonatomic, strong)NSMutableArray *imageArrM;
@property(nonatomic, assign)CGFloat keyboardHeight;

/**
 调起相册和相机
 */
@property(nonatomic, strong)CameraView *cameraView;

/**
 要发布内容
 */
@property(nonatomic, strong)PublishModel *model;
@end

@implementation PublishAnnouncementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [self addGestureRecognizer:tapGesture];
        self.backgroundColor = kHexRGBA(0x000000, 0.5);
        
        [self headerView];
        
        self.scrollView = [UIScrollView new];
        self.scrollView.backgroundColor = [UIColor whiteColor];
//        self.scrollView.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headerView.mas_bottom);
            make.bottom.equalTo(self).offset(-164);
//            make.height.mas_equalTo(300);
        }];
        self.container = [UIView new];
//        self.container.backgroundColor = [UIColor yellowColor];
        [self.scrollView addSubview:self.container];
        [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
        }];
  
        
        [self addSubvies];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHiden:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (PublishModel *)model {
    if (_model == nil) {
        _model = [[PublishModel alloc] init];
    }
    return _model;
}

- (NSMutableArray *)imageArrM {
    if (_imageArrM == nil) {
        _imageArrM = [NSMutableArray array];
    }
    return _imageArrM;
}

/**
 添加子视图
 */
- (void)addSubvies {
    [self cancelButton];
    [self publishButton];
    [self headlineLabel];
    [self contentView];
    [self titleLabel];
    [self titleField];
    [self lineView];
    [self containerView];
    [self receptLabel];
    [self selectLabel];
    [self twoLineView];
    [self textView];
    [self addView];
    [self cameraView];
}

/**
 点击发布按钮
 */
- (void)publishAction {
    NSLog(@"点击发布按钮");
    [self showLoadingView:@"正在发布"];
    NSMutableArray *tempDataArr = [NSMutableArray array];
    for (UIImage *image in self.imageArrM) {
        NSData *data = [JYCSimpleToolClass dataByImage:image];
        [tempDataArr addObject:data];
    }
    NSLog(@"%@",self.model.title);
    NSLog(@"%@",self.model.members);
    self.model.media_ids = tempDataArr;
    self.model.content = self.textView.text;
    [AnnouncementRequest publishAnnouncemenWithModel:self.model success:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(publishSuccess)]) {
            [self.delegate publishSuccess];
        }
        [self dismissLoadingViewWithCompletion:^(BOOL finish) {
            
        }];
    } fail:^(NSString * message) {
        [self dismissLoadingViewWithCompletion:^(BOOL finish) {
            
        }];
    }];
    
    
}

/**
 输入内容改变
 */
- (void)change {

}
- (void)keyboardHiden:(NSNotification *)aNotification  {
    NSLog(@"键盘消失");
    self.textView.placeholder = @"正文";
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-121);
    }];
    [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self).offset(-20);
    }];
}
- (void)keyboardShow:(NSNotification *)aNotification {
    self.textView.placeholder = @"正文";
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-self.keyboardHeight);
    }];
    [UIView animateWithDuration:1 animations:^{
        [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-self.keyboardHeight);
        }];
        [self layoutIfNeeded];
    }];
}
- (void)tapAction:(UITapGestureRecognizer *)tapGesture {
    [self.textView resignFirstResponder];
    if (self.dismissBlock) {
        self.dismissBlock(self);
    }
}
//CameraViewDelegate
- (void)pictureSelect:(PictureType)type {
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.delegate = self;
    if (type == PictureTypePhoto) {//相机
        pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else {//相册
        pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self.viewController presentViewController:pic animated:true completion:^{
        
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:true completion:^{
        UIImage *pickImage;
        
        //                pickImage = info[@"UIImagePickerControllerEditedImage"];
        
        pickImage = info[@"UIImagePickerControllerOriginalImage"];
        [self.imageArrM addObject:pickImage];
        [self.addView addImage:pickImage];
    }];
  
}
- (CameraView *)cameraView {
    if (_cameraView == nil) {
        _cameraView = [[CameraView alloc] init];
        _cameraView.backgroundColor = [UIColor whiteColor];
        _cameraView.delegate = self;
        [self addSubview:_cameraView];
        [_cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            make.bottom.equalTo(self).offset(-20);
            make.height.equalTo(@44);
        }];
    }
    return _cameraView;
}
//AddImageViewDelegate 删除的图片
- (void)didselectDeleteImage:(UIImage *)image {
    [self.imageArrM removeObject:image];
}
- (AddImageView *)addView {
    if (_addView == nil) {
        _addView = [[AddImageView alloc] init];
        _addView.delegate = self;
        _addView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_addView];
        [_addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);//-16
            make.bottom.equalTo(self).offset(-64);
            make.height.equalTo(@100);
        }];
    }
    return _addView;
}
- (AnnouncementTextView *)textView {
    if (_textView == nil) {
        _textView = [[AnnouncementTextView alloc] init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.placeholder = @"正文";
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.layoutManager.allowsNonContiguousLayout = false;
//        [_textView becomeFirstResponder];
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
//            make.width.equalTo(@30);
            make.height.mas_equalTo(150);
            make.top.equalTo(self.twoLineView.mas_bottom).offset(16);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return _textView;
}

- (UIView *)twoLineView {
    if (_twoLineView == nil) {
        _twoLineView = [[UIView alloc] init];
        _twoLineView.backgroundColor = kHexRGB(0xE8E8E8);
        [self.contentView addSubview:_twoLineView];
        [_twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.lineView);
            make.top.equalTo(self.containerView.mas_bottom);
        }];
    }
    return _twoLineView;
}
- (UILabel *)receptLabel {
    if (_receptLabel == nil) {
        _receptLabel = [[UILabel alloc] init];
        _receptLabel.text = @"接收人:";
        _receptLabel.font = [UIFont systemFontOfSize:16];
        _receptLabel.textColor = kHexRGBA(0x000000, 0.6);
        [_receptLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.containerView addSubview:_receptLabel];
        [_receptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(16);
            make.centerY.equalTo(self.containerView);
        }];
    }
    return _receptLabel;
}
- (UILabel *)selectLabel {
    if (_selectLabel == nil) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.text = @"请选择 >";
        _selectLabel.font = [UIFont systemFontOfSize:16];
        _selectLabel.textColor = kHexRGBA(0x000000, 0.2);
        [self.containerView addSubview:_selectLabel];
        [_selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.containerView).offset(-16);
            make.centerY.equalTo(self.receptLabel);
        }];
    }
    return _selectLabel;
}
- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *selectGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select)];
        [_containerView addGestureRecognizer:selectGesture];
        [self.contentView addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(52);
            make.top.equalTo(self.lineView.mas_bottom);
        }];
    }
    return _containerView;
}

/**
 打开通讯录
 */
- (void)select {
    AddressBookVC *vc = [[AddressBookVC alloc] init];
    vc.delegate = self;
    [self.viewController.navigationController pushViewController:vc animated:true];
}
//AddressBookVCDelegate
- (void)select:(NSArray *)modelArr {
    NSLog(@"%@",modelArr);
    self.model.members = modelArr;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题:";
//        _titleLabel.backgroundColor = [UIColor purpleColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = kHexRGBA(0x000000, 0.6);
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.contentView).offset(16);
            make.height.equalTo(@20);
        }];
    }
    return _titleLabel;
}
//UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.title = textField.text;
}
- (UITextField *)titleField {
    if (_titleField == nil) {
        _titleField = [[UITextField alloc] init];
        _titleField.placeholder = @"公告标题";
        _titleField.delegate = self;
        [self.contentView addSubview:_titleField];
        [_titleField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(52);
        }];
    }
    return _titleField;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kHexRGB(0xE8E8E8);
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = kHexRGB(0xF8F8F8);
        CGRect rect = CGRectMake(0, 0, kScreenWidth, 57);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(13, 13)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = rect;
        maskLayer.path = maskPath.CGPath;
        _headerView.layer.mask = maskLayer;
        [self addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(45);
            make.height.mas_equalTo(57);
        }];
    }
    return _headerView;
}
- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:kHexRGB(0x29314D) forState:UIControlStateNormal];
        _cancelButton.alpha = 0.4;
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.headerView addSubview:_cancelButton];
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headerView).offset(16);
            make.centerY.equalTo(self.headerView);
            make.size.mas_equalTo(CGSizeMake(40, 60));
        }];
    }
    return _cancelButton;
}
- (void)cancelAction {
    NSLog(@"点击取消按钮");
    if (@available(iOS 8.0, *)) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"退出将放弃编辑内容,是否确认退出" Titles:@[@"否",@"是"] leftClick:^(UIAlertAction * _Nonnull action) {
            
        } rightClick:^(UIAlertAction * _Nonnull action) {
            [self.viewController.navigationController popViewControllerAnimated:false];

        }];
        [self.viewController presentViewController:alertVC animated:true completion:^{
            
        }];
    } else {
        // Fallback on earlier versions
    }

}

- (UIButton *)publishButton {
    if (_publishButton == nil) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [_publishButton setTitleColor:kHexRGB(0x1FB1FF) forState:UIControlStateNormal];
        _publishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_publishButton addTarget:self action:@selector(publishAction) forControlEvents:UIControlEventTouchUpInside];
        [self.headerView addSubview:_publishButton];
        [_publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.size.equalTo(self.cancelButton);
            make.centerY.equalTo(self.cancelButton);
        }];
    }
    return _publishButton;
}

- (UILabel *)headlineLabel {
    if (_headlineLabel == nil) {
        _headlineLabel = [[UILabel alloc] init];
        _headlineLabel.font = [UIFont boldSystemFontOfSize:17];
        _headlineLabel.text = @"新建公告";
        [self.headerView addSubview:_headlineLabel];
        [_headlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.headerView);
        }];
    }
    return _headlineLabel;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.container addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.container);
            make.top.equalTo(self.container);
            make.bottom.equalTo(self.container).offset(0);
        }];
    }
    return _contentView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
