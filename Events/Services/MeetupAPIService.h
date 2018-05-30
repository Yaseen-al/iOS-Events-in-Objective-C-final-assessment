//
//  MeetupAPIService.h
//  Events
//
//  Created by Yaseen Al Dallash on 5/23/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetupAPIService : NSObject
+ (instancetype)sharedManager;
-(void) searchEvent:(NSString *)keyword completionHandler:(void(^)(NSError *error, NSArray *events))completion;
@end
