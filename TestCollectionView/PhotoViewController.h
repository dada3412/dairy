//
//  PhotoViewController.h
//  TestCollectionView
//
//  Created by Nico on 16/5/5.
//  Copyright © 2016年 Nico. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol DismisView <NSObject>

-(void)dismisView;

@end

@class FlickrPhoto;
@interface PhotoViewController : UIViewController
@property (strong,nonatomic) FlickrPhoto *flickrPhoto;
@property (nonatomic,assign) id<DismisView>delegate;
@end
