//
//  RSSAddViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSAddViewController.h"
#import "RSS_Feed.h"

@interface RSSAddViewController ()

@end

@implementation RSSAddViewController

@synthesize delegate = delegate_;

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

- (IBAction)done:(id)sender
{
    RSS_Feed *newFeed = [NSEntityDescription insertNewObjectForEntityForName:@"RSS_Feed" inManagedObjectContext:[RSSUtility managedObjectContext]];
    
    newFeed.name = self.RSSDisplayName.text;
    
    newFeed.feed_url = self.URL.text;
    
    newFeed.displayNotifications = [NSNumber numberWithBool:self.showNotifications.on];
    
    [[RSSUtility managedObjectContext] save:nil];
    
    [self.delegate didFinishAddingNewRSS:self];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate didFinishAddingNewRSS:self];
}

- (void)dealloc
{
    [_RSSDisplayName release];
    [_URL release];
    [_showNotifications release];
    self.delegate = nil;
    [_scrollView release];
    [_navigationBar release];
    [super dealloc];
}

@end
