//
//  SelectContactCell.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/17.
//

#import "SelectContactCell.h"

@implementation SelectContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageView.layer.cornerRadius = 20;
}
- (void)setModel:(BizDistrictTeamPlatformModel *)model{
    NSLog(@"model.type---%ld", (long)model.type);
    if (model.type == 2) {
        self.selectStatusImageView.image = [UIImage imageNamed:@"ChecksomeIcon"];
    } else if (model.type == 1) {
        self.selectStatusImageView.image = [UIImage imageNamed:@"selectIcon"];
    } else if (model.type == 0){
        self.selectStatusImageView.image = [UIImage imageNamed:@"nomarlicon"];
    } else {
        self.selectStatusImageView.image = [UIImage imageNamed:@"nomarlicon"];
    }

    
    
}
-(void)setCelltype:(cellType)celltype{
    if (celltype == contentCell){
        // 内容Cell 隐藏 编辑视图
        self.SelectIconLeftConstranint.constant = 0;
    } else {
        // 编辑Cell 显示 编辑视图
        self.SelectIconLeftConstranint.constant = 22;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)changeSelectStatus:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock();
    }
}
@end
