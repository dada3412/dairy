//
//  FlickrPhotoCell.h
//  TestCollectionView
//
//  Created by Nico on 16/5/5.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FlickrPhoto;
@interface FlickrPhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic)FlickrPhoto *photo;
@end
