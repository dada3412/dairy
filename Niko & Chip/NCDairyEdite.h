//
//  NCDairyEdite.h
//  Niko & Chip
//
//  Created by Nico on 16/5/6.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCDairyManager.h"
#import "NCImageSection.h"
@protocol DismisView <NSObject>

-(void)dismisView;

@end

@interface NCDairyEdite : UIViewController<AddImage>
@property (nonatomic,strong)NCDairy *dairy;
@property (nonatomic,assign)id<DismisView>delegate;
@end
