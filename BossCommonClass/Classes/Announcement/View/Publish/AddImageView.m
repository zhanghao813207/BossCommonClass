
//
//  AddImageView.m
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import "AddImageView.h"
#import "Masonry.h"
#import "AddimgViewCell.h"
#import "KNPhotoBrowser.h"
@interface AddImageView()<UICollectionViewDelegate,UICollectionViewDataSource,AddimgViewCellDelegate,KNPhotoBrowserDelegate>
@property(nonatomic, strong)UICollectionView *collectionview;

/**
 数据源
 */
@property(nonatomic, strong)NSMutableArray *imageArr;

/**
 浏览大图需要的数据源
 */
@property(nonatomic, strong)NSMutableArray *itemsArr;
@end

@implementation AddImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        self.imageArr = [NSMutableArray array];
    }
    return self;
}
- (NSMutableArray *)itemsArr{
    if (!_itemsArr) {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}
- (void)addImage:(KNPhotoItems *)item {
    KNPhotoItems *items = [[KNPhotoItems alloc] init];
    [self.imageArr insertObject:item.sourceImage atIndex:0];
    items.sourceImage = item.sourceImage;
    items.mediatype = item.mediatype;
    items.videourl = item.videourl;
    [self.itemsArr insertObject:items atIndex:0];
    [self.collectionview reloadData];
}
//AddimgViewCellDelegate

/**
 删除图片

 @param image 要删除的图片
 */
- (void)deleteImage:(UIImage *)image {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didselectDeleteImage:)]) {
        [self.delegate didselectDeleteImage:image];
    }
    [self.itemsArr removeObjectAtIndex:[self.imageArr indexOfObject:image]];
    [self.imageArr removeObject:image];
    [self.collectionview reloadData];
}
//KNPhotoBrowserDelegate
-(void)photoBrowserRightOperationDeleteImageSuccessWithAbsoluteIndex:(NSInteger)index {
    
}
- (void)photoBrowserRightOperationDeleteImageSuccessWithRelativeIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didselectDeleteImage:)]) {
        [self.delegate didselectDeleteImage:self.imageArr[index]];
    }
    [self.imageArr removeObjectAtIndex:index];
    [self.collectionview reloadData];
}
/**
 预览图片

 @param image 被点击的图片
 */
- (void)clickImg:(UIImage *)image {
    KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
    photoBrower.isShowDeleteButton = false;
    photoBrower.itemsArr = [self.itemsArr copy];
    photoBrower.delegate = self;
    photoBrower.isNeedPageControl = true;
    photoBrower.isNeedPageNumView = true;
    photoBrower.isNeedRightTopBtn = true;
//    photoBrower.isNeedPictureLongPress = true;
    photoBrower.isNeedPrefetch = true;
    photoBrower.isNeedPictureLongPress = false;
    photoBrower.currentIndex = [self.imageArr indexOfObject:image];

    [photoBrower present];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddimgViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.image = self.imageArr[indexPath.item];
    cell.delegate = self;
    KNPhotoItems *items = self.itemsArr[indexPath.row];
    items.sourceView = cell.imgView;
    
    return cell;
}
- (UICollectionView *)collectionview {
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        ////每个单元格的间隙
        CGFloat margin = 0;
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.itemSize = CGSizeMake((UIScreen.mainScreen.bounds.size.width - 16 - margin * 3 ) / 4, 100);
        layout.itemSize = CGSizeMake(110, 100);
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionview.backgroundColor = [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        [_collectionview registerClass:[AddimgViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:_collectionview];
        [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
    }
    return _collectionview;
}
@end
