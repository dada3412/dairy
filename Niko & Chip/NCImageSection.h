//
//  NCImageSection.h
//  Niko & Chip
//
//  Created by Nico on 16/5/6.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCAddImageCell.h"

@protocol AddImage <NSObject>

-(void)addImage:(UIButton *)sender;

@end
@interface NCImageSection : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

+(instancetype)initImageSectionWithImageKeys:(NSArray *)imageKeys;
@property(nonatomic,assign)id<AddImage>adelegate;

@end
