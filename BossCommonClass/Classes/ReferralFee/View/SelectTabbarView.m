
//
//  SelectTabbarView.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "SelectTabbarView.h"
#import "Masonry.h"
#import "JYCMethodDefine.h"
#import "RecommendedModel.h"
#import "UIView+GetVC.h"
@interface SelectTabbarView ()

/**
 删除按钮
 */
@property(nonatomic, strong)UIButton *deleteButton;
@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UIView *lineView;
@end

@implementation SelectTabbarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self deleteButton];
        [self selectButton];
        [self lineView];
    }
    return self;
}
- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    for (RecommendedModel *model in modelArr) {
        if (!model.is_complete) {
//            [self.selectButton setTitle:@"提交" forState:UIControlStateNormal];
//            [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
            self.selectButton.enabled = false;
            [self.selectButton setTitleColor:kHexRGB(0xC4C6C7) forState:UIControlStateNormal];
        }
    }
}
- (void)setSeletcArr:(NSArray *)seletcArr {
    _seletcArr = seletcArr;
    for (RecommendedModel *model in seletcArr) {
        NSLog(@"%d",model.is_complete);
        if (model.is_complete) {
            self.selectButton.enabled = true;
            [self.selectButton setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
        }else {
            self.selectButton.enabled = false;
            [self.selectButton setTitleColor:kHexRGB(0xC4C6C7) forState:UIControlStateNormal];
        }
    }
    if (self.seletcArr.count == 0) {
        [self.selectButton setTitle:@"全部提交" forState:UIControlStateNormal];
        [self.deleteButton setTitle:@"全部删除" forState:UIControlStateNormal];
    }else {
        [self.selectButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }
    NSLog(@"%@",self.seletcArr);
//    NSLog(@"%@",self.modelArr);
}
- (void)setIsAll:(BOOL)isAll {
    _isAll = isAll;
    if (isAll) {
//        [self.selectButton setTitle:@"全部提交" forState:UIControlStateNormal];
//        [self.deleteButton setTitle:@"全部删除" forState:UIControlStateNormal];
    }else {
//        [self.selectButton setTitle:@"提交" forState:UIControlStateNormal];
//        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }
}
- (UIButton *)deleteButton {
    if (_deleteButton == nil) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"全部删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.deleteButton);
            make.left.top.equalTo(self).offset(16);
            make.centerY.equalTo(self);
        }];
    }
    return _deleteButton;
}
- (UIButton *)selectButton {
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setTitle:@"全部提交" forState:UIControlStateNormal];
        [_selectButton setTitleColor:kHexRGB(0x1173E4) forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(select) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.height.mas_equalTo(44);
            make.centerY.equalTo(self);
        }];
    }
    return _selectButton;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.right.equalTo(self);
            make.height.equalTo(@(1 / UIScreen.mainScreen.scale));
        }];
    }
    return _lineView;
}
- (void)select {
    if ([self.selectButton.currentTitle containsString:@"全部提交"]) {
        self.isAll = true;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectModel:)]) {
        [self.delegate selectModel:self];
    }
}
- (void)setIsFinish:(BOOL)isFinish {
    _isFinish = isFinish;
    if (self.isFinish) {
        self.selectButton.hidden = true;
    }
}

- (void)deleteAction {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:@"删除后信息将从你的列表中清楚,是否继续删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.deleteButton.currentTitle containsString:@"全部删除"]) {
            self.isAll = true;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteModel:)]) {
            [self.delegate deleteModel:self];
        }
    }];
    [alertVc addAction:noAction];
    [alertVc addAction:yesAction];
    [self.viewController presentViewController:alertVc animated:true completion:^{
        
    }];
    
   
}

@end
