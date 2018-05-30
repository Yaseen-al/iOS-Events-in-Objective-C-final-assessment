//
//  EventTableViewCell.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "EventTableViewCell.h"
#import "ImageAPIClient.h"
// class extension
@interface EventTableViewCell ()
@property (nonatomic) UILabel *eventName;
@property (nonatomic) UIImageView *eventImage;
@property (nonatomic) UILabel *eventDate;
@property (nonatomic) UILabel *eventRSVP;
@property (nonatomic) UILabel *groupName;
@property (nonatomic) UILabel *eventDescription;

@property (nonatomic, copy) NSString *urlString;
@end

@implementation EventTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"eventCell"];
    if (self) {
        // setup views
        [self setupViews];
        _urlString = [[NSString alloc] init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setupViews {
    [self setupEventName];
    [self setupEventImage];
    [self setupGroupName];
    [self setupEventDate];
    [self setupEventDescription];
}

-(void) setupEventName{
    _eventName = [[UILabel alloc] init];
    [self addSubview:_eventName];
    _eventName.numberOfLines = 0;
    
    //Constraints
    _eventName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventName.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
                                              [_eventName.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              [_eventName.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:5],
                                              ]];
}
-(void) setupEventImage{
    _eventImage = [[UIImageView alloc] init];
    [self addSubview:_eventImage];
    _eventImage.image = [UIImage imageNamed:@"defaultImage"];
//    _eventImage.contentMode = UIViewContentModeScaleAspectFit;
    
    //Constraints
    _eventImage.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventImage.topAnchor constraintEqualToAnchor:self.eventName.bottomAnchor constant:5],
                                              [_eventImage.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [_eventImage.widthAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.30],
                                              [_eventImage.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10],
                                              [_eventImage.heightAnchor constraintEqualToAnchor:self.heightAnchor multiplier:0.45]

                                              ]];
}

-(void) setupGroupName{
    _groupName = [[UILabel alloc] init];
    [self addSubview:_groupName];
    
    //Constraints
    _groupName.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_groupName.topAnchor constraintEqualToAnchor:self.eventName.bottomAnchor constant:5],
                                              [_groupName.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_groupName.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              ]];
    
}

-(void) setupEventDate{
    _eventDate = [[UILabel alloc] init];
    [self addSubview:_eventDate];
    
    //Constraints
    _eventDate.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventDate.topAnchor constraintEqualToAnchor:self.groupName.bottomAnchor constant:5],
                                              [_eventDate.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_eventDate.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              ]];
}
-(void) setupEventDescription{
    _eventDescription = [[UILabel alloc] init];
    [self addSubview:_eventDescription];
    [_eventDescription setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal] ;
    _eventDescription.numberOfLines = 5;
    //Constraints
    _eventDescription.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventDescription.topAnchor constraintEqualToAnchor:self.eventDate.bottomAnchor constant:5],
                                              [_eventDescription.leftAnchor constraintEqualToAnchor:self.eventImage.rightAnchor constant:5],
                                              [_eventDescription.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-5],
                                              [_eventDescription.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:5]
                                              ]];
}

- (void)configureCellWith:(Event *)event{
    _eventName.text = event.eventName;
    _eventImage.image = [UIImage imageNamed:@"defaultImage"];
    _eventImage.contentMode = UIViewContentModeScaleAspectFit;
    _groupName.text = event.groupName;
    _eventDate.text = event.localDate;
    if ([event.localDate isEqualToString:@""]){
        _eventDate.text = @"No Date";

    }
    _eventRSVP.text = [NSString stringWithFormat:@"RSVP: %ld", event.rsvpCount];
    _eventDescription.text = event.eventDescription;
    
    [ImageAPIClient.sharedManager getImage:event.highResLink completionHandler:^(NSError *error, UIImage *image) {
        if (error){
            return ;
        }
        self.eventImage.image = image;
    }];

    
}
@end
