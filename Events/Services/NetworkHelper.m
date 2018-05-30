//
//  NetwrokHelper.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/23/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkHelper.h"

@interface NetworkHelper ()
//Properties here are private because it is an Extension

@property (nonatomic) NSURLSession *urlSession;
@end

@implementation NetworkHelper

+(instancetype)sharedManager{
    static NetworkHelper *networkHelper;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        networkHelper = [[NetworkHelper alloc] init];
        
        
    });
    return networkHelper;
}

-(instancetype) init{
    self = [super init];
    if (self){
        _urlSession = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
    }
    return self;
}
- (void)performRequest:(NSURLRequest *)request completionHandler:(void(^)(NSError *error, NSData *data))completion{
    
    NSURLSessionDataTask *dataTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error){
                completion(error, nil);
                
            }else{
                completion(nil, data);
            }
        });
    }];
    [dataTask resume];

}



@end
