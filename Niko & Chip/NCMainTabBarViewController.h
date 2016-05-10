//
//  NCMainTabBarViewController.h
//  Niko & Chip
//
//  Created by Nico on 16/4/23.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCHomeToolbar.h"
#import "NCTableViewSelector.h"
@interface NCMainTabBarViewController : UITabBarController<ToolbarButtonShowViewDelegate,TableViewSelectorDelegate>

@end
