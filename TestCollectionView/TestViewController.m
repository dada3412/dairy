//
//  TestViewController.m
//  TestCollectionView
//
//  Created by Nico on 16/5/4.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "TestViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"
#import "FlickrPhotoHeaderView.h"
#import <MessageUI/MessageUI.h>

@interface TestViewController ()<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSMutableDictionary *searchResults;
@property (strong,nonatomic) NSMutableArray *searches;
@property (strong,nonatomic) Flickr *flickr;
@property (nonatomic)BOOL isShare;
@property (nonatomic,strong)PhotoViewController *photoViewController;
@property (nonatomic,strong)NSMutableArray *selectPhotos;
- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searches=[@[] mutableCopy];
    self.searchResults=[@{} mutableCopy];
    self.flickr=[[Flickr alloc]init];
    
//    UINib *nib=[UINib nibWithNibName:@"FlickrPhotoCell" bundle:nil];
//    
//    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"MyCell"];
    [self.collectionView registerClass:[FlickrPhotoCell class] forCellWithReuseIdentifier:@"MyCell"];
    UINib *secondNib=[UINib nibWithNibName:@"FlickrPhotoHeaderView" bundle:nil];
    [self.collectionView registerNib:secondNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FlickrPhotoHeaderView"];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork"]];
    
    UIImage *navBarImage=[[UIImage imageNamed:@"navbar"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolbar setBackgroundImage:navBarImage forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage *shareButtonImage=[[UIImage imageNamed:@"button"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackgroundImage:shareButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *textFiledImage=[[UIImage imageNamed:@"search_field"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFiledImage];
    self.selectPhotos=[@[] mutableCopy];
    
}

-(PhotoViewController *)photoViewController
{
    if (!_photoViewController) {
        _photoViewController=[[PhotoViewController alloc]init];
    }
    return _photoViewController;
}



- (IBAction)shareButtonTapped:(id)sender {
    if (!self.isShare) {
        [self.shareButton setStyle:UIBarButtonItemStyleDone];
        [self.shareButton setTitle:@"Done"];
        [self.collectionView setAllowsMultipleSelection:YES];
        self.isShare=YES;
    }else
    {
        self.isShare=NO;
        [self.shareButton setTitle:@"Share"];
        [self.shareButton setStyle:UIBarButtonItemStylePlain];
        [self.collectionView setAllowsMultipleSelection:NO];
        if (self.selectPhotos.count>0) {
            [self showMailComposerAndSend];
        }
        for (NSIndexPath *indexPath in self.collectionView.indexPathsForVisibleItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
        }
        [self.selectPhotos removeAllObjects];
    }
}


#pragma mark --textField delegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    // 1
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {            
            // 2
            if(![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %ld photos matching %@", [results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results;}
            // 3
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            }); } else { // 1
                NSLog(@"Error searching Flickr: %@", error.localizedDescription);
            } }];
    [textField resignFirstResponder];
    return YES; }

#pragma mark --collection dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.searches count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *searchTerm=self.searches[section];
    return [[self.searchResults objectForKey:searchTerm] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    NSString *searchItem=self.searches[indexPath.section];
    cell.photo=self.searchResults[searchItem][indexPath.row];
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FlickrPhotoHeaderView *headerView=[self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FlickrPhotoHeaderView" forIndexPath:indexPath];
    
    NSString *searchItem=self.searches[indexPath.section];
    [headerView setSearchText:searchItem];
    return headerView;
}
#pragma mark --collection delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchItem=self.searches[indexPath.section];
    FlickrPhoto *photo=self.searchResults[searchItem][indexPath.row];

    if (!_isShare) {
                self.photoViewController.delegate=self;
        self.photoViewController.flickrPhoto=photo;
        self.photoViewController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        [self presentViewController:self.photoViewController animated:YES completion:nil];
    }else
    {
        [self.selectPhotos addObject:photo];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShare) {
        NSString *searchItem=self.searches[indexPath.section];
        FlickrPhoto *photo=self.searchResults[searchItem][indexPath.row];
        [self.selectPhotos removeObject:photo];
    }
}

#pragma mark --collectionFlowLayout delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchItem=self.searches[indexPath.section];
    FlickrPhoto *photo=self.searchResults[searchItem][indexPath.row];
    
    CGSize size=photo.thumbnail.size.width>0?photo.thumbnail.size:CGSizeMake(100, 100);
    size.height+=35;
    size.width+=35;
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(50, 20, 50, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(400, 90);
}

#pragma mark --DismisView Delegate
-(void)dismisView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)showMailComposerAndSend
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Check out these Flickr Photos"];
        NSMutableString *emailBody = [NSMutableString string]; for(FlickrPhoto *flickrPhoto in self.selectPhotos)
        {
            NSString *url = [Flickr flickrPhotoURLForFlickrPhoto: flickrPhoto size:@"m"];
            [emailBody appendFormat:
             @"<div><img src='%@'></div><br>",url];
        }
        [mailer setMessageBody:emailBody isHTML:YES];
        [self presentViewController:mailer animated:YES completion:^{}];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Mail Failure"
                              message:
                              @"Your device doesn't support in-app email"
                              delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show]; }
}

- (void)mailComposeController: (MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:^{}];
}
@end
