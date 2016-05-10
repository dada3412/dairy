//
//  NCImageStore.h
//  Niko & Chip
//
//  Created by Nico on 16/4/30.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

@interface NCImageStore : NSObject<NSCopying>
+(instancetype)shareImage;
-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(NSDictionary *)imageDicFromKey:(NSString *)key;
-(UIImage *)thumbnailImageFromKey:(NSString *)key;
-(UIImage *)middleImageFromKey:(NSString *)key;
-(UIImage *)largeImageFromKey:(NSString *)key;
-(void)deleteImageFromKey:(NSString *)key;
@end
