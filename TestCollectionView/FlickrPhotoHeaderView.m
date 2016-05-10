//
//  FlickrPhotoHeaderView.m
//  TestCollectionView
//
//  Created by Nico on 16/5/5.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "FlickrPhotoHeaderView.h"

@interface FlickrPhotoHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;

@end

@implementation FlickrPhotoHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    self=[[[NSBundle mainBundle] loadNibNamed:@"FlickrPhotoHeaderView" owner:self options:nil] firstObject];
    return self;
}

-(void)setSearchText:(NSString *)text
{
    self.searchLabel.text=text;
    UIImage *shareButtonImage = [[UIImage imageNamed:@"header_bg"] resizableImageWithCapInsets:
                                 UIEdgeInsetsMake(68, 68, 68, 68)];
    self.backgroundView.image = shareButtonImage;
    self.backgroundView.center = self.center;
}

@end
