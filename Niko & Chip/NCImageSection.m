//
//  NCImageSection.m
//  Niko & Chip
//
//  Created by Nico on 16/5/6.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCImageSection.h"
#import "NCImageViewCell.h"
#import "NCImageStore.h"
#import "CommenDefine.h"
@interface NCImageSection ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)NSMutableArray *imageKeys;
@end

@implementation NCImageSection

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    self.delegate=self;
    self.dataSource=self;
    [self registerClass:[NCAddImageCell class] forCellWithReuseIdentifier:@"addImageCell"];
    UINib *nib=[UINib nibWithNibName:@"NCImageViewCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:@"imageViewCell"];
    return self;
}

+(instancetype)initImageSectionWithImageKeys:(NSMutableArray *)imageKeys
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    NCImageSection *imageSection=[[NCImageSection alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100) collectionViewLayout:layout];
    imageSection.imageKeys=imageKeys;
    imageSection.backgroundColor=[UIColor yellowColor];
    layout.itemSize=CGSizeMake(75, 75);
    layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    return imageSection;
}
#pragma mark dateSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imageKeys count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==self.imageKeys.count) {
        NCAddImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"addImageCell" forIndexPath:indexPath];
        [cell.addImageButton addTarget:self.adelegate action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else
    {
        NCImageViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"imageViewCell" forIndexPath:indexPath];
        NSString *imageKey=self.imageKeys[indexPath.row];
        UIImage *image=[[NCImageStore shareImage] thumbnailImageFromKey:imageKey];
        cell.imageView.image=image;
        return cell;
    }
}



@end
