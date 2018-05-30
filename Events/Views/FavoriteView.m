//
//  FavoriteView.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "FavoriteView.h"

@implementation FavoriteView

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
    _eventsTableView = [[UITableView alloc] init];
}
#pragma mark - Add SubViews
-(void) addSubViews{
    [self addSubview:_eventsTableView];
}
#pragma mark - SubViews Constraints
-(void) configureConstraints{

    
    //Configure TableView
    _eventsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventsTableView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_eventsTableView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
                                              [_eventsTableView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [_eventsTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                                              ]];
}


@end
