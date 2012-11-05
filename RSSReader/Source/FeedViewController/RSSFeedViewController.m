//
//  RSSFeedViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSFeedViewController.h"
#import "RSSWebViewController.h"
#import "RSSFeedViewCell.h"
#import "RSSNetworkManager.h"

@interface RSSFeedViewController ()

@end

@implementation RSSFeedViewController

@synthesize selectedRSSFeed = selectedRSSFeed_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[RSSNetworkManager sharedNetworkManager] fetchAllFeedsForRSSWithURL:[NSURL URLWithString:[self.selectedRSSFeed feed_url]]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.selectedRSSFeed articles] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FeedViewCell";
    
    RSSFeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil == cell)
    {
        cell = [[RSSFeedViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FeedViewCell"];
    }
    
    RSS_Article *article = [[self.selectedRSSFeed.articles allObjects] objectAtIndex:indexPath.row];
    
    cell.titleTextField.text = article.name;
    
    cell.subtitleTextField.text = article.article_url;
    
    if(![article.isRead boolValue])
    {
        cell.unreadImageView.image = [UIImage imageNamed:@"orange-ball"];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - View Controller delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[RSSWebViewController class]])
    {
        RSS_Article *article = [[self.selectedRSSFeed.articles allObjects] objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        [(RSSWebViewController *)segue.destinationViewController setArticleToDisplay:article];
    }
}

@end
