//
//  ImageAPIClient.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "ImageAPIClient.h"
#import "NetworkHelper.h"
@interface ImageAPIClient()
@property (nonatomic) NSCache *sharedCache;
@property (nonatomic) NSMutableURLRequest *urlRequest;

@end

@implementation ImageAPIClient

+ (instancetype)sharedManager{
    static ImageAPIClient *sharedManager;
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        sharedManager = [[ImageAPIClient alloc] init];
    });
    return sharedManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _sharedCache = [[NSCache alloc] init];
    }
    return self;
}
- (void)cacheImage:(UIImage *)image forKey:(NSString *)key {
    [self.sharedCache setObject:image forKey:key];
}
- (UIImage *)getImageCacheForKey:(NSString *)key {
    return [self.sharedCache objectForKey:key];
}
- (void)getImage:(NSString *)urlString completionHandler:(void (^)(NSError *, UIImage *))completion{
    if ([self getImageCacheForKey:urlString]){
        UIImage *cachedImage = [self getImageCacheForKey:urlString];
        completion(nil,cachedImage);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NetworkHelper.sharedManager performRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error){
            completion(error, nil);
            return ;
        }else{
            UIImage *image = [[UIImage alloc] initWithData:data];
            completion(nil, image);
            [self cacheImage:image forKey:urlString];
            return ;
        }
    }];

}
@end
