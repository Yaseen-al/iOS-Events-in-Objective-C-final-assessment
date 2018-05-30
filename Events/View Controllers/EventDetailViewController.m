//
//  EventDetailViewController.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "EventDetailViewController.h"
#import "EventDetailView.h"
#import "DataPersistenceHelper.h"

@interface EventDetailViewController ()
@property EventDetailView *eventDetailView;

@end

@implementation EventDetailViewController

- (instancetype)initWithEvent:(Event *)event{
    self = [super init];
    if (self){
        _event = event;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationBar];
    [self allocInitSubViews];
    [self addSubViews];
    [self configureSubViewsConstraints];
    [self.eventDetailView configureWith:_event];
}



#pragma mark - Configure NavigationBar
-(void) configureNavigationBar{
    UIBarButtonItem *favoriteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEvent)];
    self.navigationItem.rightBarButtonItem = favoriteButton;
}

#pragma mark - View Allocation
- (void) allocInitSubViews{
    _eventDetailView = [[EventDetailView alloc] init];
    
}

#pragma mark - Add SubViews
- (void) addSubViews{
    [self.view addSubview:_eventDetailView];
}


#pragma mark - Configure SubViews Constraints
- (void) configureSubViewsConstraints{
    _eventDetailView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventDetailView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [_eventDetailView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [_eventDetailView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor],
                                              [_eventDetailView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor],
                                              ]];
}


-(void)saveEvent{
    NSLog(@"Saving event is working");
    [DataPersistenceHelper saveEvent:_event];
}

@end
