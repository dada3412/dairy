//
//  NCImageStore.m
//  Niko & Chip
//
//  Created by Nico on 16/4/30.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "NCImageStore.h"
#import "CommenDefine.h"
@interface NCImageStore()
@property(nonatomic,strong)NSMutableDictionary *imagesDic;
@end
@implementation NCImageStore

-(NSMutableDictionary *)imagesDic
{
    if (!_imagesDic) {
        _imagesDic=[NSMutableDictionary new];
    }
    return _imagesDic;
}


static NCImageStore * instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[super allocWithZone:zone];
    });
    return instance;
}
+(instancetype)shareImage
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[NCImageStore alloc]init];
    });
    return instance;
}

-(id)copyWithZone:(NSZone *)zone
{
    return instance;
}

-(NSString *)imagePathForKey:(NSString *)key
{
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:key];
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.imagesDic setObject:[self imagesDicFromImage:image] forKey:key];
    NSString *imagePath=[self imagePathForKey:key];
    NSData *imageData=UIImageJPEGRepresentation(image, 1.0);
    
    [imageData writeToFile:imagePath atomically:YES];
}

-(NSDictionary *)imagesDicFromImage:(UIImage *)image
{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    CGSize middleImageSize=CGSizeMake(SCREEN_WIDTH, 150);
    UIImage *middleImage=[self getThumbnilImageFromImage:image WithSize:middleImageSize];
    CGSize thumbnailimageSize=CGSizeMake(75, 75);
    UIImage *thumbnailImage=[self getThumbnilImageFromImage:image WithSize:thumbnailimageSize];
    UIImage *largeImage=image;
    [dic setObject:middleImage forKey:@"middleImage"];
    [dic setObject:thumbnailImage forKey:@"thumbnailImage"];
    [dic setObject:largeImage forKey:@"largeImage"];
    return dic;
}



-(UIImage *)getThumbnilImageFromImage:(UIImage *)image WithSize:(CGSize)size
{
    CGSize origImageSize=image.size;
    CGFloat ratio=MAX(size.width/origImageSize.width, size.height/origImageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGRect newRect=CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    [path addClip];
    
    CGRect projectRect;
    projectRect.size.width=origImageSize.width*ratio;
    projectRect.size.height=origImageSize.height*ratio;
    projectRect.origin.x=(size.width-projectRect.size.width)/2;
    projectRect.origin.y=(size.height-projectRect.size.height)/2;
    
    [image drawInRect:projectRect];
    
    UIImage *thumbnailImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}

-(UIImage *)thumbnailImageFromKey:(NSString *)key
{
    NSDictionary *dic=self.imagesDic[key];
    if (!dic) {
        NSString *imagePath=[self imagePathForKey:key];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            dic=[self imagesDicFromImage:image];
        }else
            NSLog(@"unable to find image");
    }
    return dic[@"thumbnailImage"];
}

-(UIImage *)middleImageFromKey:(NSString *)key
{
    NSDictionary *dic=self.imagesDic[key];
    if (!dic) {
        NSString *imagePath=[self imagePathForKey:key];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            dic=[self imagesDicFromImage:image];
        }else
            NSLog(@"unable to find image");
    }
    return dic[@"middleImage"];
}

-(UIImage *)largeImageFromKey:(NSString *)key
{
    NSDictionary *dic=self.imagesDic[key];
    if (!dic) {
        NSString *imagePath=[self imagePathForKey:key];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            dic=[self imagesDicFromImage:image];
        }else
            NSLog(@"unable to find image");
    }
    return dic[@"largeImage"];
}

-(NSDictionary *)imageDicFromKey:(NSString *)key
{
    
    NSDictionary *dic=self.imagesDic[key];
    if (!dic) {
        NSString *imagePath=[self imagePathForKey:key];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            dic=[self imagesDicFromImage:image];
        }else
            NSLog(@"unable to find image");
    }
    return dic;
}

-(void)deleteImageFromKey:(NSString *)key;
{
    [self.imagesDic removeObjectForKey:key];
}

@end
