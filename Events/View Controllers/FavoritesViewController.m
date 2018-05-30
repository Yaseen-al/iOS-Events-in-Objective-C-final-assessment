//
//  FavoritesViewController.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "FavoritesViewController.h"
#import "Event.h"
#import "FavoriteView.h"
#import "DataPersistenceHelper.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
@interface FavoritesViewController ()
@property (nonatomic) FavoriteView *favoriteView;
@property (nonatomic)NSArray *events;
@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocInitProperties];
    [self allocInitSubViews];
    [self addSubViews];
    [self configureSubViewsConstraints];
    [self setDelegates];
    [self.favoriteView.eventsTableView registerClass:EventTableViewCell.class forCellReuseIdentifier:@"eventCell"];
    self.favoriteView.eventsTableView.rowHeight = UITableViewAutomaticDimension;
    self.favoriteView.eventsTableView.estimatedRowHeight = 200;
    self.view.backgroundColor = UIColor.whiteColor;

    
    _events = [DataPersistenceHelper loadEvents];
}
#pragma mark - Set Delegates

- (void) setDelegates{
    _favoriteView.eventsTableView.dataSource = self;
    _favoriteView.eventsTableView.delegate = self;
}


#pragma mark - Properties Allocation
- (void) allocInitProperties{
    _events = [[NSArray alloc] init];
}

#pragma mark - View Allocation
- (void) allocInitSubViews{
    _favoriteView = [[FavoriteView alloc] init];
    
}

#pragma mark - Add SubViews
- (void) addSubViews{
    [self.view addSubview: _favoriteView];
}


#pragma mark - Configure SubViews Constraints
- (void) configureSubViewsConstraints{
    _favoriteView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_favoriteView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [_favoriteView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [_favoriteView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor],
                                              [_favoriteView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor],
                                              ]];
}

#pragma mark - TableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Event *currentEvent = _events[indexPath.row];
    EventTableViewCell *eventCell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    if (eventCell){
        [eventCell configureCellWith:currentEvent];
        return  eventCell;
    }
    else{
        UITableViewCell *defaultCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"defaultCell"];
        defaultCell.textLabel.text = currentEvent.eventName;
        return defaultCell;}
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _events.count;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Event *currentEvent = _events[indexPath.row];
    EventDetailViewController *eventDetailViewController = [[EventDetailViewController alloc] initWithEvent:currentEvent];
    [self.navigationController pushViewController:eventDetailViewController animated:true];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}




@end
