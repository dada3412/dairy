//
//  NCPlaceHolderTextView.h
//  Niko & Chip
//
//  Created by Nico on 16/5/12.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceholderDelegate<NSObject>
-(void)addTag:(NSString *)str;
-(void)saveTagData:(NSString *)str withIndex:(int)index;
-(void)saveTitleData:(NSString *)str;
@end

@interface NCPlaceholderTextView : UITextView
@property (nonatomic,strong) NSString *placeholder;
@property (nonatomic)NSInteger limitNumbersOfString;
@property (nonatomic)BOOL isSizeToFit;
@property (nonatomic) BOOL isAdd;
@property (nonatomic,strong) NSString *addString;
@property (assign,nonatomic)id<PlaceholderDelegate>placeholderDelegate;
@end
