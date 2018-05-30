//
//  DataPersistenceHelper.h
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
@interface DataPersistenceHelper : NSObject

+(NSMutableArray*)loadEvents;
+(void)saveEvent:(Event *)event;
+(NSString *)getDocumentPath;
+(void) saveToDisk:(NSMutableArray*)events;

@end
