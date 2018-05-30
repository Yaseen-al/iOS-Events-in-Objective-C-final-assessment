//
//  EventsViewController.m
//  Events
//
//  Created by Yaseen Al Dallash on 5/25/18.
//  Copyright © 2018 Yaseen Al Dallash. All rights reserved.
//

#import "EventsViewController.h"
#import "EventsView.h"
#import "Event.h"
#import "MeetupAPIService.h"
#import "EventTableViewCell.h"
#import "EventDetailViewController.h"
#import "ImageAPIClient.h"


@interface EventsViewController ()
#pragma mark - Private properties
@property (nonatomic) EventsView *eventsView;
@property (nonatomic)NSArray *events;
@property (copy, nonatomic)NSString *searchTerm;
@end

@implementation EventsViewController

#pragma mark - View Lifecycles

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allocInitProperties];
    [self allocInitSubViews];
    [self addSubViews];
    [self configureSubViewsConstraints];
    [self setDelegates];
    [self.eventsView.eventsTableView registerClass:EventTableViewCell.class forCellReuseIdentifier:@"eventCell"];
    self.eventsView.eventsTableView.rowHeight = UITableViewAutomaticDimension;
    self.eventsView.eventsTableView.estimatedRowHeight = 200;
    self.view.backgroundColor = UIColor.whiteColor;

}
#pragma mark - Set Delegates

- (void) setDelegates{
    _eventsView.eventsTableView.dataSource = self;
    _eventsView.eventsTableView.delegate = self;
    _eventsView.eventsSearchBar.delegate = self;
}


#pragma mark - Properties Allocation
- (void) allocInitProperties{
    _events = [[NSArray alloc] init];
}

#pragma mark - View Allocation
- (void) allocInitSubViews{
    _eventsView = [[EventsView alloc] init];
    
}

#pragma mark - Add SubViews
- (void) addSubViews{
    [self.view addSubview:_eventsView];
}


#pragma mark - Configure SubViews Constraints
- (void) configureSubViewsConstraints{
    _eventsView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [_eventsView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                               [_eventsView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                               [_eventsView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor],
                                               [_eventsView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor],
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

#pragma mark - SearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchTerm = searchBar.text;
    NSLog(@"the search term is %@", _searchTerm);
    [MeetupAPIService.sharedManager searchEvent:_searchTerm completionHandler:^(NSError *error, NSArray *events) {
        if(error){
            NSLog(@"Dev error: %@", error);
        }else{
            self.events = events;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.eventsView.eventsTableView reloadData];
            });
        }
    }];
}



@end
