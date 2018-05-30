//
//  MeetupAPIService.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/23/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeetupAPIService.h"
#import "MeetupAPIService.h"
#import "Event.h"
#import "APIKeys.h"
#import "NetworkHelper.h"
#import "Constants.h"

@implementation MeetupAPIService
#pragma mark - Singleton instance
+(instancetype)sharedManager{
    static MeetupAPIService *meetupAPIService;
    static dispatch_once_t singleton;
    dispatch_once(&singleton, ^{
        meetupAPIService = [[MeetupAPIService alloc] init];
    });
    return meetupAPIService;
}

-(void) searchEvent:(NSString *)keyword completionHandler:(void(^)(NSError *error, NSArray *events))completion{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=%@&lat=40.72&lon=-73.84", APIKEY,keyword]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NetworkHelper.sharedManager performRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error){
            completion(error, nil);
        }else{
            NSError *error;
            if (data){
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if(error){
                    completion(error, nil);
                }else{
                    for (NSDictionary *dict in jsonObjects){
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    
                    completion(nil, events);
                }
            }
            
            
            
        }
    }];

    
}


@end
