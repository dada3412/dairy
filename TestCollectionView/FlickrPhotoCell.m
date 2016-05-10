//
//  FlickrPhotoCell.m
//  TestCollectionView
//
//  Created by Nico on 16/5/5.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "FlickrPhotoCell.h"
#import "FlickrPhoto.h"
@implementation FlickrPhotoCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    NSArray *views=[[NSBundle mainBundle] loadNibNamed:@"FlickrPhotoCell" owner:self options:nil];
    NSLog(@"frame");
    self=[views firstObject];
    UIView *bgView = [[UIView alloc]
                      initWithFrame:self.backgroundView.frame]; bgView.backgroundColor = [UIColor blueColor]; bgView.layer.borderColor = [[UIColor whiteColor]CGColor];
    bgView.layer.borderWidth = 4;
    self.selectedBackgroundView = bgView;
    return self;
}


//-(id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//    UIView *bgView = [[UIView alloc]
//                      initWithFrame:self.backgroundView.frame]; bgView.backgroundColor = [UIColor blueColor]; bgView.layer.borderColor = [[UIColor whiteColor]CGColor];
//    bgView.layer.borderWidth = 4;
//    self.selectedBackgroundView = bgView;
//    }
//    NSLog(@"coder");
//    return self;
//}

-(void)setPhoto:(FlickrPhoto *)photo
{
    if (_photo!=photo) {
        _photo=photo;
    }
    self.imageView.image=_photo.thumbnail;
}
@end
