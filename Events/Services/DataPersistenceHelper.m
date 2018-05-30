//
//  DataPersistenceHelper.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "DataPersistenceHelper.h"
#import "Event.h"
@interface DataPersistenceHelper ()
@end

@implementation DataPersistenceHelper



//THis function will git all saved events



//THis function will save an event to current list
+(void)saveEvent:(Event *)event{
    NSMutableArray <Event *> *allevents;
    if ([self loadEvents].count == 0){
      allevents = [[NSMutableArray alloc] init];
    }else{
        allevents = [self loadEvents];
    }
    [allevents addObject:event];
    [self saveToDisk:allevents];
}

+(NSMutableArray*)loadEvents{
    NSString *filePath = [self getDocumentPath];
    NSMutableArray <Event *> *events = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if(!events)
        NSLog(@"failed to unarchive events");
    return events;
}

//This function will save the events list to disk

+(void) saveToDisk:(NSMutableArray*)events{
    NSString *filePath = [self getDocumentPath];
    BOOL archived = [NSKeyedArchiver archiveRootObject:events toFile:filePath];
    if (!archived) {
        NSLog(@"failed to archive");
    } else {
        NSLog(@"events saved to documents path: %@", filePath);
    }
}

+(NSString *)getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths.firstObject;
    NSString *filename = @"filename.plist";
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    return path;
}



@end
