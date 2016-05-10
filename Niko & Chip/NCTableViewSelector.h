//
//  NCTableViewSelector.h
//  Niko & Chip
//
//  Created by Nico on 16/4/26.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TableViewSelectorDelegate <NSObject>

-(void)hideView:(UIButton *)sender;

@end
@interface NCTableViewSelector : UIViewController
@property (nonatomic,assign)id<TableViewSelectorDelegate> delegate;
@end

