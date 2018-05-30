//
//  EventsView.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "EventsView.h"

@implementation EventsView

#pragma mark - Inits

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self allocInitSubViews];
        [self addSubViews];
        [self configureConstraints];
    }
    return  self;
}

#pragma mark - View Allocation
-(void) allocInitSubViews{
    _eventsSearchBar = [[UISearchBar alloc] init];
    _eventsTableView = [[UITableView alloc] init];
}
#pragma mark - Add SubViews
-(void) addSubViews{
    [self addSubview:_eventsSearchBar];
    [self addSubview:_eventsTableView];
}
#pragma mark - SubViews Constraints
-(void) configureConstraints{
    //Configure SearchBar
    _eventsSearchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventsSearchBar.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_eventsSearchBar.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [_eventsSearchBar.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              ]];

    //Configure TableView
    _eventsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventsTableView.topAnchor constraintEqualToAnchor:self.eventsSearchBar.bottomAnchor],
                                              [_eventsTableView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [_eventsTableView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [_eventsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                                              ]];
}

@end
