
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
#import "NNBUtilRequest.h"
#import "NNBUploadManager.h"
#import "SelectContactVc.h"
#import "UIViewController+StoryBoard.h"
#import "BizDistrictTeamPlatformModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
typedef void(^Result)(NSData *fileData, NSString *fileName);

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
//@property(nonatomic, strong)UITextField *titleField;
@property(nonatomic, strong)AnnouncementTextView *titleTextView;
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

/**
 临时存放附件数组
 */
@property(nonatomic, strong)NSMutableArray *tempArr;

/**
 背景
 */
@property(nonatomic, strong)UIView *bgView;
@end

@implementation PublishAnnouncementView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti2:) name:@"selectArrNotification" object:nil];
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
//        [self addGestureRecognizer:tapGesture];
        self.backgroundColor = [UIColor colorNamed:@"bgcolor_F5F5F5_000000"];
//        self.view.backgroundColor =
        [self headerView];
        
        self.scrollView = [UIScrollView new];
        self.scrollView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fieldChange) name:UITextFieldTextDidChangeNotification object:nil];
        [self.model addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.model addObserver:self forKeyPath:@"members" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self.model addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}
-(void)noti2:(NSNotification *)noti{
    
    //使用object处理消息
    NSMutableArray * idArr = [NSMutableArray array];
    
    NSMutableArray *infoArr = [noti object];
    self.contentArr = infoArr;
    for (BizDistrictTeamPlatformModel *teamListModel in infoArr){
        if (teamListModel.type == 1) {
            for (BizDistrictTeamPlatformModel *PlatformModel in teamListModel.PlatformArr){
                if (PlatformModel.supplierArr) {
                    for (BizDistrictTeamPlatformModel *supplierModel in PlatformModel.supplierArr){
                        for (BizDistrictTeamPlatformModel *cityModel in supplierModel.cityArr){
                            [idArr addObject:cityModel.vendorTargetId];
                        }
                    }
                } else {
                    // 趣活内部
                    [idArr addObject:PlatformModel.vendorTargetId];
                }
            }
        } else if (teamListModel.type == 2 ){
            for (BizDistrictTeamPlatformModel *PlatformModel in teamListModel.PlatformArr){
                if (PlatformModel.type == 1) {
                    if (PlatformModel.supplierArr){
                        for (BizDistrictTeamPlatformModel *supplierModel in PlatformModel.supplierArr){
                            for (BizDistrictTeamPlatformModel *cityModel in supplierModel.cityArr){
                                [idArr addObject:cityModel.vendorTargetId];
                            }
                        }
                    } else {
                        // 趣活内部
                        [idArr addObject:PlatformModel.vendorTargetId];
                    }
                    
                } else if (PlatformModel.type == 2) {
                    for (BizDistrictTeamPlatformModel *supplierModel in PlatformModel.supplierArr){
                        if (supplierModel.type == 1) {
                            for (BizDistrictTeamPlatformModel *cityModel in supplierModel.cityArr){
                                [idArr addObject:cityModel.vendorTargetId];
                            }
                        } else if (supplierModel.type == 2) {
                            for (BizDistrictTeamPlatformModel *cityModel in supplierModel.cityArr){
                                if (cityModel.type == 1) {
                                    [idArr addObject:cityModel.vendorTargetId];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (idArr.count <= 0){
        if (self.selectContentStatus){
            self.selectContentStatus(@"未选择联系人");
        }
        
        [self showStatus:@"请选择联系人"];
    } else {
        if (self.selectContentStatus){
            self.selectContentStatus(@"已选择联系人");
        }
        for(UIViewController* Controller in self.viewController.navigationController.viewControllers){
            if ([NSStringFromClass([Controller class]) isEqualToString:NSStringFromClass([self.viewController class])]){
                [self.viewController.navigationController popToViewController:Controller animated:true];
            }
        }
        self.model.members = idArr;
        self.selectLabel.text = @"已选择 >";
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.model.title.length > 0 && self.model.content.length > 0 && self.model.members.count > 0) {
        self.publishButton.userInteractionEnabled = true;
        [self.publishButton setTitleColor:kHexRGB(0x1FB1FF) forState:UIControlStateNormal];
    }else {
        self.publishButton.userInteractionEnabled = false;
        [self.publishButton setTitleColor:UIColor.lightGrayColor forState:UIControlStateNormal];
    }
}

/**
 标题输入框改变
 */
////标题的最大长度
static int textLength = 30;
- (void)fieldChange {
    //    self.model.title = self.titleField.text;
    //    if (self.titleField.text.length > textLength) {
    //        self.titleField.text = [self.titleField.text substringToIndex:textLength];
    //    }
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
    
    [self headerView];
    [self cancelButton];
    [self publishButton];
    [self headlineLabel];
    [self contentView];
    [self titleLabel];
    //    [self titleField];
    [self titleTextView];
    [self lineView];
    [self containerView];
    [self receptLabel];
    [self selectLabel];
    [self twoLineView];
    [self textView];
    [self addView];
    [self cameraView];
    [self bgView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self.titleField becomeFirstResponder];
    });
}
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        [self insertSubview:_bgView belowSubview:self.headerView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(60);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return _bgView;
}
/**
 点击发布按钮
 */
- (void)publishAction {
    NSLog(@"点击发布按钮");
    [self endEditing:true];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"是否确认发布?" Titles:@[@"否",@"是"] leftClick:^(UIAlertAction * _Nonnull action) {
        
    } rightClick:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingView:@"正在发布"];
        });
        //        [self showLoadingView:@"正在发布"];
        
        self.tempArr = [NSMutableArray array];
        NSMutableArray *tempDataArr = [NSMutableArray array];
        
        self.model.media_ids = tempDataArr;
        self.model.content = self.textView.text;
        
        if (self.imageArrM.count > 0) {
            
            for (NSInteger i = 0;i < self.imageArrM.count; i ++) {
                [kUserDefault setValue:@"uploadImage" forKey:@"uploadImage"];
                __block NSData *data;
                NSString *filetype;
                // 如果上传文件为图片
                if ([self.imageArrM[i] isKindOfClass:[UIImage class]]){
                    filetype = @"jpg";
                    UIImage *imageNew = [NNBUploadManager compressionImage:self.imageArrM[i] proportion:0.8];
                    data = [JYCSimpleToolClass dataByImage:imageNew];
                    [tempDataArr addObject:data];
                    
                    [self uploadqiniu:data filetype:filetype];
//                    [self uploadS3WithData:data filePolicy:filetype];
                } else {
                    NSDictionary *dic = self.imageArrM[i];
                    PHAsset *model = [dic objectForKey:@"value"];
                    filetype = [dic objectForKey:@"type"];
                    [[PHImageManager defaultManager] requestAVAssetForVideo:model options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                        
                        if (asset) {
                            AVURLAsset *a = (AVURLAsset *)asset;
                            NSData *data = [NSData dataWithContentsOfURL:a.URL];
                            if (data){
                                [tempDataArr addObject:data];
                                [self uploadqiniu:data filetype:filetype];
//                                [self uploadS3WithData:data filePolicy:filetype];

                            }
                        }
                    }];
                    //                    [self getVideoFromPHAsset:model Complete:^(NSData *fileData, NSString *fileName) {
                    //                        data = fileData;
                    //
                    //                    }];
                }
            }
        }else {
            [self publish];
        }
    }];
    
    [self.viewController presentViewController:alertVC animated:true completion:^{
        
    }];
}

// 上传S3
- (void)uploadS3WithData:(NSData *)data filePolicy:(NSString *)filePolicy{
    __weak typeof(self) weakSelf = self;
    //获取s3配置,
    [NNBUtilRequest requestGetS3ConfigInfoWithDomain:@"notice" filePolicy:filePolicy Success:^(NSString *url, NSDictionary *policyKey) {
        // 数据上传s3
        [NNBUtilRequest uploadImageToS3WithData:data contentType:filePolicy bucketUrl:url policyDict:policyKey Success:^(NSString *fileKey) {
            [kUserDefault removeObjectForKey:@"uploadImage"];
            [AnnouncementRequest uploadDomain_type:Domain_typeNotice Storage_type:Storage_typeS3 file_type:filePolicy file_key:fileKey Success:^(id  _Nonnull response) {
                NSLog(@"%@",response);
                if (response && response[@"record"]){
                    [weakSelf.tempArr addObject:response[@"record"][@"_id"]];
                      if (weakSelf.tempArr.count == self.imageArrM.count) {
                          weakSelf.model.media_ids = self.tempArr;
                          [weakSelf publish];
                      }
                }
              
            } fail:^(NSString * _Nonnull message) {
                
            }];
        } fail:^(id error) {
        }];
    } fail:^(id error) {
        
    }];
}


- (void)uploadqiniu:(NSData *)data filetype:(NSString *)filetype {
    [NNBUtilRequest UtilRequestGetQNTokenWithOperateType:filetype Success:^(NSString *path, NSString *qiniu_token) {
        NSLog(@"fdfdfd%@",qiniu_token);
        if (qiniu_token) {
            [self uploadQiniu:data path:path token:qiniu_token fileType:filetype];
        }
    } fail:^(id error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissLoadingViewWithCompletion:nil];;
        });
    }];
}
/**
 上传到七牛

 */
- (void)uploadQiniu:(NSData *)data path:(NSString *)path token:(NSString *)qiniu_token fileType:(NSString *)filetype {

    [[NNBUploadManager defaultManager] putData:data key:path token:qiniu_token progressHandler:^(NSString *key, float percent) {
    } complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"%@",key);
        [kUserDefault removeObjectForKey:@"uploadImage"];
        [AnnouncementRequest uploadDomain_type:Domain_typeNotice Storage_type:Storage_typeQIniu file_type:filetype file_key:key Success:^(id  _Nonnull response) {
            NSLog(@"%@",response);
            [self.tempArr addObject:response[@"record"][@"_id"]];
            if (self.tempArr.count == self.imageArrM.count) {
                self.model.media_ids = self.tempArr;
                [self publish];
            }
        } fail:^(NSString * _Nonnull message) {

        }];

    } fail:^(id error) {

    }];
}



/**
 发布公告
 */
- (void)publish {
    self.model.proxyId = self.proxyId;
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
    NSLog(@"%@",self.textView.text);
    self.model.title = self.titleTextView.text;
    if (self.titleTextView.text.length > textLength) {
        self.titleTextView.text = [self.titleTextView.text substringToIndex:textLength];
    }
    self.model.content = self.textView.text;
}
- (void)keyboardHiden:(NSNotification *)aNotification  {
    NSLog(@"键盘消失");
    self.textView.placeholder = @"请输入正文";
    [self.scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-64);
    }];
    [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (kIsiPhoneX) {
            make.bottom.equalTo(self).offset(-64);
        }else {
            make.bottom.equalTo(self).offset(0);
        }
        
    }];
}
- (void)keyboardShow:(NSNotification *)aNotification {
    self.textView.placeholder = @"请输入正文";
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboardHeight = keyboardRect.size.height;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-(self.keyboardHeight + 64));
    }];
    [UIView animateWithDuration:1 animations:^{
        [self.cameraView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (kIsiPhoneX) {
                make.bottom.equalTo(self).offset(-self.keyboardHeight - 20);
            }else {
                make.bottom.equalTo(self).offset(-self.keyboardHeight);
            }
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
    [self endEditing:true];
    if (type == PictureTypePhoto){
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 用户点击 "OK"
                        [self showImagePickerVc:type];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // 用户点击 不允许访问
                        [self showStatus:@"拒绝后不可上传图片视频"];
                        return;
                    });
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self showImagePickerVc:type];
        } else {
            [self showStatus:@"请在设置-开启相册权限"];
        }
    } else if (type == PictureTypeCamera){
        // 检查用户对相机的授权状态
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
            [self showStatus:@"请在设置-开启相机权限"];
            return;
        } else {
            [self showImagePickerVc:type];
        }
    }
    
    
    
    
}
- (void)showImagePickerVc:(PictureType)type{
    if (self.imageArrM.count > 4) {
        [self showStatus:@"最多可上传5张图片"];
        return;
    }
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.delegate = self;
    if (type == PictureTypePhoto) {//相机
        pic.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
        pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else {//相册
        pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    pic.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.viewController presentViewController:pic animated:true completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:true completion:^{
        
        NSString *fileType = info[@"UIImagePickerControllerMediaType"];
        if ([fileType isEqualToString:@"public.movie"]){
            NSURL *url = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
            NSString *fileType;
            NSArray *strAry = [[NSString stringWithFormat:@"%@", url] componentsSeparatedByString:@"ext="];
            if (strAry.count > 1){
                fileType = strAry[1];
            } else {
                fileType = @"";
            }
            PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
            PHAsset *asset = fetchResult.firstObject;
            PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
            
            CGFloat size = (CGFloat) [[resource valueForKey:@"fileSize"] longLongValue] / (1024*1024);
            if (size > 20){
                [self showStatus:@"大于20M的文件不支持上传"];
                return;
            }
            KNPhotoItems *items = [[KNPhotoItems alloc] init];
            items.sourceImage = [self getVideoPreViewImage:url];
            items.mediatype = mediaVideo;
            items.videourl = url;
            NSDictionary *dic = @{@"type": fileType, @"value": asset};
            [self.addView addImage:items];
            [self.imageArrM addObject:dic];
        } else {
            UIImage *pickImage = info[@"UIImagePickerControllerOriginalImage"];
            KNPhotoItems *items = [[KNPhotoItems alloc] init];
            items.sourceImage = pickImage;
            items.mediatype = mediaImage;
            [self.addView addImage:items];
            [self.imageArrM addObject:pickImage];
        }
    }];
    
}
- (CGFloat)getFileSize:(NSString *)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }
    return filesize;
}
- (CameraView *)cameraView {
    if (_cameraView == nil) {
        _cameraView = [[CameraView alloc] init];
        _cameraView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        _cameraView.delegate = self;
        [self addSubview:_cameraView];
        [_cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            if (kIsiPhoneX){
                make.bottom.equalTo(self).offset(-64);
            } else {
                make.bottom.equalTo(self).offset(0);
            }
            
            make.height.equalTo(@64);
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
        _addView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        [self addSubview:_addView];
        [_addView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);//-16
            if (kIsiPhoneX){
                make.bottom.equalTo(self).offset(-64 - 64);
            } else {
                make.bottom.equalTo(self).offset(-64);
            }
            make.height.equalTo(@100);
        }];
    }
    return _addView;
}
- (AnnouncementTextView *)textView {
    if (_textView == nil) {
        _textView = [[AnnouncementTextView alloc] init];
        //        _textView.backgroundColor = [UIColor redColor];
        _textView.placeholder = @"请输入正文";
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.layoutManager.allowsNonContiguousLayout = false;
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
    //
    return _textView;
}

- (UIView *)twoLineView {
    if (_twoLineView == nil) {
        _twoLineView = [[UIView alloc] init];
        _twoLineView.backgroundColor = [UIColor colorNamed:@"linecolor_E8E8E8_2B2B2B"];
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
        _receptLabel.textColor = [UIColor colorNamed:@"boss_000000-60_FFFFFF-60"];
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
        _selectLabel.text = @"请选择接收人 >";
        _selectLabel.font = [UIFont systemFontOfSize:16];
        _selectLabel.textColor = [UIColor colorNamed:@"linecolor_E8E8E8_2B2B2B"];
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
        _containerView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        UITapGestureRecognizer *selectGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectReceiver)];
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
 打开
 */
- (void)selectReceiver {
#ifdef kBossManager
    SelectContactVc *vc = [SelectContactVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    vc.contentArr = self.contentArr;
    vc.wppId = self.wppId;
    [self.viewController.navigationController pushViewController:vc animated:true];
#else
    AddressBookVC *vc = [[AddressBookVC alloc] init];
    vc.delegate = self;
    vc.wppId = self.wppId;
    vc.iscloseTalk = true;
    //    vc.contentArr = self.contentArr;
    vc.teamArr = self.model.members;
    vc.isShowSelectBar = true;
    [self.viewController.navigationController pushViewController:vc animated:true];
#endif
    
    //    AddressBookVC *vc = [[AddressBookVC alloc] init];
    //    vc.delegate = self;
    //    vc.teamArr = self.model.members;
    //    vc.isShowSelectBar = true;
    // 选择联系人优化
    //    SelectContactVc *vc = [SelectContactVc storyBoardCreateViewControllerWithBundle:@"BossCommonClass" StoryBoardName:@"EntrustAccountRegistration"];
    //    vc.contentArr = self.contentArr;
    //    vc.wppId = self.wppId;
    //    [self.viewController.navigationController pushViewController:vc animated:true];
}
//AddressBookVCDelegate
- (void)selectModelDelegate:(NSArray *)modelArr {
    self.model.members = modelArr;
    self.selectLabel.textColor = [UIColor colorNamed:@"boss_000000-90_FFFFFF-90"];
    self.selectLabel.text = @"已选择 >";
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题:";
        //        _titleLabel.backgroundColor = [UIColor purpleColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorNamed:@"boss_000000-60_FFFFFF-60"];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.top.equalTo(self.titleTextView).offset(10);
            //            make.centerY.equalTo(self.titleTextView);
            make.height.equalTo(@20);
        }];
    }
    return _titleLabel;
}
//UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.title = textField.text;
}
- (AnnouncementTextView *)titleTextView {
    if (_titleTextView == nil) {
        _titleTextView = [[AnnouncementTextView alloc] init];
        _titleTextView.placeholder = @"请输入标题";
        [_titleTextView becomeFirstResponder];
        _titleTextView.textAlignment = NSTextAlignmentLeft;
//        _titleTextView.backgroundColor = [UIColor redColor];
//        _titleTextView.textColor = UIColor.redColor;
//        [UIColor colorNamed:@"boss_000000-90_FFFFFF-90"];
//        [self.contentView addSubview:_titleTextView];
        //        _titleTextView.backgroundColor = [UIColor redColor];
        _titleTextView.font = [UIFont boldSystemFontOfSize:17];
        [self.contentView addSubview:_titleTextView];
        [_titleTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(4);
            //            make.centerY.equalTo(self.titleLabel);
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(40);
            //            make.height.equalTo(self.titleLabel);
        }];
    }
    return _titleTextView;
}
//- (UITextField *)titleField {
//    if (_titleField == nil) {
//        _titleField = [[UITextField alloc] init];
//        _titleField.placeholder = @"请输入标题";
//        _titleField.backgroundColor = [UIColor redColor];
//        _titleField.delegate = self;
//        _titleField.font = [UIFont boldSystemFontOfSize:17];
//        [self.contentView addSubview:_titleField];
//        [_titleField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.titleLabel.mas_right).offset(4);
//            make.centerY.equalTo(self.titleLabel);
//            make.right.equalTo(self.contentView);
//            make.height.mas_equalTo(52);
//        }];
//    }
//    return _titleField;
//}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorNamed:@"linecolor_E8E8E8_2B2B2B"];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.top.equalTo(self.titleTextView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView);
            make.height.mas_equalTo(1 / UIScreen.mainScreen.scale);
        }];
    }
    return _lineView;
}
- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor colorNamed:@"boss_F8F8F8_1A1A1A"];
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
        [_cancelButton setTitleColor:[UIColor colorNamed:@"boss_000000-40_FFFFFF-40"] forState:UIControlStateNormal];
//        _cancelButton.alpha = 0.4;
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
    

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"退出将放弃编辑内容,是否确认退出?" Titles:@[@"否",@"是"] leftClick:^(UIAlertAction * _Nonnull action) {
            
        } rightClick:^(UIAlertAction * _Nonnull action) {
            [self.viewController.navigationController popViewControllerAnimated:false];

        }];
        [self.viewController presentViewController:alertVC animated:true completion:^{
            
        }];
    
}

- (UIButton *)publishButton {
    if (_publishButton == nil) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _publishButton.userInteractionEnabled = false;
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        [_publishButton setTitleColor:[UIColor colorNamed:@"boss_000000-40_0087FF"] forState:UIControlStateNormal];
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
        _contentView.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
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
- (UIImage*)getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}
@end
