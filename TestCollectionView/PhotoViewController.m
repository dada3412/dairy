//
//  PhotoViewController.m
//  TestCollectionView
//
//  Created by Nico on 16/5/5.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "PhotoViewController.h"
#import "FlickrPhoto.h"
#import "Flickr.h"
@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)done:(id)sender;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFlickrPhoto:(FlickrPhoto *)flickrPhoto
{
    _flickrPhoto=flickrPhoto;
    if(self.flickrPhoto.largeImage) {
        
        
        self.imageView.image = self.flickrPhoto.largeImage; } else {
            // 2
            self.imageView.image = self.flickrPhoto.thumbnail;
            // 3
            [Flickr loadImageForPhoto:self.flickrPhoto thumbnail:NO completionBlock:^(UIImage *photoImage, NSError *error) {
                if(!error) { // 4
                    dispatch_async(dispatch_get_main_queue(), ^{ self.imageView.image =
                        self.flickrPhoto.largeImage;
                    }); }
            }];
}
}



-(void)viewDidAppear:(BOOL)animated
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender {
    [self.delegate dismisView];
}
@end
