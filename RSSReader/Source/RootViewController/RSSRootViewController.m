//
//  RSSRootViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSRootViewController.h"
#import "RSSFeedViewController.h"
#import "RSS_Feed.h"
#import "RSSRootViewCell.h"
#import "RSSDatabaseManager.h"

@interface RSSRootViewController ()

@end

@implementation RSSRootViewController

@synthesize RSSFeedsArray = RSSFeedsArray_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    self.RSSFeedsArray = nil;
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.RSSFeedsArray = [[RSSDatabaseManager sharedDatabaseManager] allFeeds];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.RSSFeedsArray = [[RSSDatabaseManager sharedDatabaseManager] allFeeds];
    
    [self.tableView reloadData];
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
    
    RSS_Feed *feed = [self.RSSFeedsArray objectAtIndex:[indexPath row]];
    
    if([feed.isNew boolValue])
    {
        cell.rssImageView.image = [UIImage imageNamed:@"rss_new"];
        
        [cell.UnreadCountBackgroundView setHidden:YES];
    }
    
    else
    {
        cell.rssImageView.image = [UIImage imageNamed:@"rss"];
        
        [cell.UnreadCountBackgroundView setHidden:NO];
        
        NSNumber *unreadCount = [[RSSDatabaseManager sharedDatabaseManager] unreadArticlesInFeed:feed];
        
        cell.unreadCountField.text = [unreadCount stringValue];
    }
    
    cell.titleTextField.text = [feed name];
    
    cell.subtitleTextField.text = [feed feed_url];
    
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
        RSS_Feed *feed = [self.RSSFeedsArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
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
    
    self.RSSFeedsArray = [[RSSDatabaseManager sharedDatabaseManager] allFeeds];
    
    [self.tableView reloadData];
}

@end
