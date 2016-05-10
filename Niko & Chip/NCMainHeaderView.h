//
//  NCMainHeaderView.h
//  Niko & Chip
//
//  Created by Nico on 16/4/27.
//  Copyright © 2016年 Nico. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol ButtonTapped <NSObject>

-(void)tappedLeftButton:(UIButton *)sender;
-(void)tappedRightButton:(UIButton *)sender;

@end

@interface NCMainHeaderView : UIView
@property(assign,nonatomic)id<ButtonTapped>delegate;
@end
