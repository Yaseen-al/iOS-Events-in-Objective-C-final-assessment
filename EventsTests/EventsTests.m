//
//  EventsTests.m
//  EventsTests
//
//  Created by Yaseen Al Dallash on 5/23/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Event.h"
#import "Constants.h"
#import "NetworkHelper.h"
#import "APIKeys.h"
@interface EventsTests : XCTestCase

@end

@implementation EventsTests


-(void)testMeetUpAPI{
    //This is an Async. test
    //BackGround test requirments - expectation
    XCTestExpectation *exp = [self expectationWithDescription:@"Events found"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.meetup.com/find/events?key=%@&fields=group_photo&text=cooking&lat=40.72&lon=-73.84", APIKEY]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [ NetworkHelper.sharedManager performRequest:request completionHandler:^(NSError *error, NSData *data) {
        if (error){
            XCTFail(@"Data task error : %@", error.localizedDescription);
        }else{
            NSError *error;
            if (data){
                NSMutableArray <Event *> *events = [[NSMutableArray alloc] init];
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                if(error){
                    XCTFail(@"Deserialization Error %@", error.localizedDescription);
                }else{
                    for (NSDictionary *dict in jsonObjects){
                        Event *event = [[Event alloc] initWithDict:dict];
                        [events addObject:event];
                    }
                    XCTAssertGreaterThan(events.count, 0);
                    
                    [exp fulfill];
                }
            }
            
            
        }
    }];
    
    
    //BackGround test requirments - WaitTimeForExpectations
    [self waitForExpectations:@[exp] timeout:10.0];
}

-(void)testReadingJSONFile {
    //need to get the path for "events.json"
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"json" inDirectory:nil];
    if (path) {
        XCTAssertNotNil(path);
    } else {
        XCTFail(@"PATH NOT FOUND");
    }
}

-(void)testCreatingEventModel {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"json" inDirectory:nil];
    if (path) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSError *error;
        if (data) {
            NSMutableArray *events = [[NSMutableArray alloc] init];
            id jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                XCTFail(@"serialization error: %@", error.localizedDescription);
            } else {
                //serialization is successful
                for (NSDictionary *dict in jsonObjects) {
                    Event *event = [[Event alloc] initWithDict:dict];
                    [events addObject:event];
                }
                
                XCTAssertEqual(events.count, 3);
                
                Event *firstEvent = (Event *)events[0];
                XCTAssertEqualObjects(firstEvent.eventCreated, @1525190016000);
                
            }
        } else {
            XCTFail(@"data at file %@ is nil", path);
        }
    } else {
        XCTFail(@"PATH NOT FOUND");
    }
}



@end
