//
//  Flickr.m
//  Flickr Search
//
//  Created by Brandon Trebitowski on 6/28/12.
//  Copyright (c) 2012 Brandon Trebitowski. All rights reserved.
//

#import "Flickr.h"
#import "FlickrPhoto.h"

#define kFlickrAPIKey @"a974aef8f8ca855263a7d547e5530c5c"

@implementation Flickr

+ (NSString *)flickrSearchURLForSearchTerm:(NSString *) searchTerm
{
//    searchTerm = [searchTerm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"st:%@",[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&page=1&format=json&nojsoncallback=1&auth_token=72157667320723590-e51a833b3c3aa199",kFlickrAPIKey,searchTerm]);

//    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&format=json&nojsoncallback=1&auth_token=72157667320723590-e51a833b3c3aa199&api_sig=9d6725a807a7070b24fea4c884c08e9d",kFlickrAPIKey,searchTerm];
    switch (searchTerm.length) {
        case 1:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f40d1f56dec225b17d62a0d251bb89b7&text=messi&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157665595508574-710d797d53eed73d&api_sig=8bc2ce3ca6410758ddb2ad7ecb4d2819";
            break;
            
        case 2:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=98fb0f1ac7a877fa9e393a791a52f270&text=lyte+V+&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157668004085745-207b0488701fdb81&api_sig=c06c79fcd72e3bb42bd67e1753edd6a9";
            break;
            
        case 3:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f40d1f56dec225b17d62a0d251bb89b7&text=eminem&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157665595508574-710d797d53eed73d&api_sig=5a6c1657cf7e9173a9e4e7f4560083a0";
            break;
            
        case 4:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f40d1f56dec225b17d62a0d251bb89b7&text=converse&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157665595508574-710d797d53eed73d&api_sig=eb56c41d850053b4798f0e0cb0a39dca";
            break;
            
        case 5:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=98fb0f1ac7a877fa9e393a791a52f270&text=new+balance+998&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157668004085745-207b0488701fdb81&api_sig=6db520a70c1b410e698e0609ccc3155d";
            break;
            
        case 6:
            return @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f40d1f56dec225b17d62a0d251bb89b7&text=gel+lyte&per_page=10&page=2&format=json&nojsoncallback=1&auth_token=72157665595508574-710d797d53eed73d&api_sig=9c5cc8595215a357920aca3612c556e1";
            break;
        default:
            return @"";
            break;
    }
}

+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size
{
    if(!size)
    {
        size = @"m";
    }
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%d/%lld_%@_%@.jpg",flickrPhoto.farm,flickrPhoto.server,flickrPhoto.photoID,flickrPhoto.secret,size];
}

- (void)searchFlickrForTerm:(NSString *) term completionBlock:(FlickrSearchCompletionBlock) completionBlock
{
    NSString *searchURL = [Flickr flickrSearchURLForSearchTerm:term];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSError *error = nil;
        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                           encoding:NSUTF8StringEncoding
                                                              error:&error];
        if (error != nil) {
            completionBlock(term,nil,error);
        }
        else
        {
            // Parse the JSON Response
            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                              options:kNilOptions
                                                                                error:&error];
            if(error != nil)
            {
                completionBlock(term,nil,error);
            }
            else
            {
                NSString * status = searchResultsDict[@"stat"];
                if ([status isEqualToString:@"fail"]) {
                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrSearch" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: searchResultsDict[@"message"]}];
                    completionBlock(term, nil, error);
                } else {
                
                    NSArray *objPhotos = searchResultsDict[@"photos"][@"photo"];
                    NSMutableArray *flickrPhotos = [@[] mutableCopy];
                    for(NSMutableDictionary *objPhoto in objPhotos)
                    {
                        FlickrPhoto *photo = [[FlickrPhoto alloc] init];
                        photo.farm = [objPhoto[@"farm"] intValue];
                        photo.server = [objPhoto[@"server"] intValue];
                        photo.secret = objPhoto[@"secret"];
                        photo.photoID = [objPhoto[@"id"] longLongValue];
                        
                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:photo size:@"m"];
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                                  options:0
                                                                    error:&error];
                        UIImage *image = [UIImage imageWithData:imageData];
                        photo.thumbnail = image;
                        
                        [flickrPhotos addObject:photo];
                    }
                    
                    completionBlock(term,flickrPhotos,nil);
                }
            }
        }
    });
}

+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock
{
    
    NSString *size = thumbnail ? @"m" : @"b";
    
    NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:size];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                  options:0
                                                    error:&error];
        if(error)
        {
            completionBlock(nil,error);
        }
        else
        {
            UIImage *image = [UIImage imageWithData:imageData];
            if([size isEqualToString:@"m"])
            {
                flickrPhoto.thumbnail = image;
            }
            else
            {
                flickrPhoto.largeImage = image;
            }
            completionBlock(image,nil);
        }
        
    });
}



@end
