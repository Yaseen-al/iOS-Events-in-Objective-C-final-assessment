//
//  EventDetailView.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "EventDetailView.h"
#import "ImageAPIClient.h"

@interface EventDetailView()
@property (nonatomic) UILabel *eventName;
@property (nonatomic) UIImageView *eventImage;
@property (nonatomic) UILabel *eventDate;
@property (nonatomic) UILabel *eventRSVP;
@property (nonatomic) UILabel *groupName;
@property (nonatomic) UITextView *eventDescription;
@end

@implementation EventDetailView

#pragma mark - Inits

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = UIColor.whiteColor;
        [self allocInitSubViews];
        [self addSubViews];
        [self configureConstraints];
    }
    return  self;
}

#pragma mark - View Allocation
-(void) allocInitSubViews{
    _eventName = [[UILabel alloc] init];
    _eventImage = [[UIImageView alloc] init];
    _groupName = [[UILabel alloc] init];
    _eventDate = [[UILabel alloc] init];
    _eventRSVP = [[UILabel alloc] init];
    _eventDescription = [[UITextView alloc] init];
}
#pragma mark - Add SubViews
-(void) addSubViews{
    [self addSubview:_eventName];
    [self addSubview:_eventImage];
    [self addSubview:_groupName];
    [self addSubview:_eventDate];
    [self addSubview:_eventRSVP];
    [self addSubview:_eventDescription];

}
#pragma mark - SubViews Constraints
-(void) configureConstraints{
    //EventName Constraints
    _eventName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventName.topAnchor constraintEqualToAnchor:self.topAnchor constant:50],
                                              [_eventName.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              [_eventName.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:5],
                                              ]];
    
    //EventImage Constraints
    _eventImage.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventImage.topAnchor constraintEqualToAnchor:self.eventName.bottomAnchor constant:5],
                                              [_eventImage.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [_eventImage.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.30],
                                              [_eventImage.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10],
                                              [_eventImage.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.45]
                                              ]];
    
    //Group Name Constraints
    _groupName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_groupName.topAnchor constraintEqualToAnchor:self.eventName.bottomAnchor constant:5],
                                              [_groupName.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_groupName.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              ]];
    //EventRSVP Constraints
    _eventRSVP.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventRSVP.topAnchor constraintEqualToAnchor:self.groupName.bottomAnchor constant:5],
                                              [_eventRSVP.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_eventRSVP.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              ]];
    
    // EventDate Constraints
    _eventDate.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventDate.topAnchor constraintEqualToAnchor:self.eventRSVP.bottomAnchor constant:5],
                                              [_eventDate.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_eventDate.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              ]];
    
    // EventDescription Constraints
    _eventDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventDescription.topAnchor constraintEqualToAnchor:self.eventDate.bottomAnchor constant:5],
                                              [_eventDescription.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_eventDescription.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              [_eventDescription.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:5]
                                              ]];

}
- (void)configureWith:(Event *)event{
    //Event Name
    _eventName.text = event.eventName;
    _eventName.numberOfLines = 2;
    _eventName.textAlignment = NSTextAlignmentCenter;
    
    //Event Image
    _eventImage.image = [UIImage imageNamed:@"defaultImage"];
    _eventImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [ImageAPIClient.sharedManager getImage:event.highResLink completionHandler:^(NSError *error, UIImage *image) {
        if (error){
            return ;
        }
        self.eventImage.image = image;
    }];
    
    //Event Date
    _eventDate.text = event.localDate;
    if ([event.localDate isEqualToString:@""]){
        _eventDate.text = @"No Date";
        
    }
    //Group Name
    _groupName.text = event.groupName;
    
    //Event RSVP
    _eventRSVP.text = [NSString stringWithFormat:@"RSVP: %ld", event.rsvpCount];
    
    //Event Description
    _eventDescription.text = event.eventDescription;
}


@end
