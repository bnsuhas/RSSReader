//
//  RSSRootViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSRootViewController.h"
#import "RSSFeedViewController.h"
#import "RSSNetworkManager.h"
#import "RSS_Feed.h"
#import "RSSRootViewCell.h"
#import "RSSDatabaseManager.h"

@interface RSSRootViewController ()

@end

@implementation RSSRootViewController

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

#pragma mark - Action Methods

- (IBAction)AddRSSFeed:(id)sender
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RSS_Feed"];
    
    return [[[RSSUtility managedObjectContext] executeFetchRequest:fetchRequest error:nil] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RootViewCell";
    
    RSSRootViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil == cell)
    {
        cell = [[[RSSRootViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RootViewCell"] autorelease];
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"RSS_Feed"];
    
    NSArray *feedsArray = [[RSSUtility managedObjectContext] executeFetchRequest:request error:nil];
    
    RSS_Feed *feed = [feedsArray objectAtIndex:[indexPath row]];
    
    if([feed.isNew boolValue])
    {
        cell.rssImageView.image = [UIImage imageNamed:@"rss_new"];
    }
    
    else
    {
        cell.rssImageView.image = [UIImage imageNamed:@"rss"];
    }
    
    cell.titleTextField.text = [feed name];
    
    cell.subtitleTextField.text = [feed feed_url];
    
    [[RSSNetworkManager sharedNetworkManager] fetchAllFeedsForRSSWithURL:[NSURL URLWithString:[feed feed_url]]];
    
    return cell;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


#pragma mark - View Controller delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[RSSAddViewController class]])
    {
        [(RSSAddViewController *)segue.destinationViewController setDelegate:self];
    }
    
    else if([segue.destinationViewController isKindOfClass:[RSSFeedViewController class]])
    {
        NSArray *feedsArray = [[RSSDatabaseManager sharedDatabaseManager] allFeeds];
        
        RSS_Feed *feed = [feedsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        if ([feed.isNew boolValue])
        {
            feed.isNew = [NSNumber numberWithBool:NO];
            
            [[RSSUtility managedObjectContext] save:nil];
        }
        
        [(RSSFeedViewController *)segue.destinationViewController setSelectedRSSFeed:feed];
    }
}

#pragma mark - RSSAddViewController delegate

-(void)didFinishAddingNewRSS:(RSSAddViewController *)inSender
{
    [inSender dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

@end
