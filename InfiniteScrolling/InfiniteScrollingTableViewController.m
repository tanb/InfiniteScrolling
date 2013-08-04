//
//  InfiniteScrollingTableViewController.m
//  InfiniteScrolling
//
//  Created by tanB on 8/2/13.
//  Copyright (c) 2013 tanB. All rights reserved.
//

#import "InfiniteScrollingTableViewController.h"

@interface InfiniteScrollingTableViewController ()

@end

@implementation InfiniteScrollingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (!self) return nil;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self scrollToRow:5 atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollToRow:(NSInteger)row
   atScrollPosition:(UITableViewScrollPosition)scrollPosition
           animated:(BOOL)animated
{
    NSInteger numberOfDataSource = 6;
    NSInteger realRow = (50000 - 50000 % numberOfDataSource) - (numberOfDataSource - row);
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:realRow inSection:0]
                          atScrollPosition:scrollPosition
                                  animated:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%d", (indexPath.row % 6) * 10];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

@end
