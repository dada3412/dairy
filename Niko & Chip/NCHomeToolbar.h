//
//  NCHomeToolbar.h
//  Niko & Chip
//
//  Created by Nico on 16/4/24.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolbarButtonShowViewDelegate <NSObject>
-(void)showSelectView:(UIButton *)sender;
@end

@interface NCHomeToolbar : UIToolbar
@property (nonatomic,assign) id <ToolbarButtonShowViewDelegate> aDelegate;
//@property (nonatomic,strong) UITableView * tagTableView;
//@property (nonatomic,strong) UITableView *mainTableView;
@end

