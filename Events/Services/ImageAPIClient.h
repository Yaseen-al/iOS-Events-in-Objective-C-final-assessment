//
//  ImageAPIClient.h
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageAPIClient : NSObject
+ (instancetype)sharedManager;

-(void) getImage:(NSString *)urlString completionHandler:(void(^)(NSError *error, UIImage *image))completion;
@end
