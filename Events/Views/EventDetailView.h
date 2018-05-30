//
//  EventDetailView.h
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventDetailView : UIView
-(void) configureWith:(Event *) event;

@end
