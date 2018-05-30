//
//  NetwrokHelper.h
//  Events
//
//  Created by Yaseen Al Dallash on 5/23/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHelper : NSObject
+ (instancetype)sharedManager;
- (void)performRequest:(NSURLRequest *)request completionHandler:(void(^)(NSError *error, NSData *data))completion;
@end
