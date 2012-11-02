//
//  RSSAddViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSAddViewController.h"
#import "RSS_Feed.h"
#import "RSSDatabaseManager.h"

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
    if(!self.RSSDisplayName.text.length)
    {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"RSS title cannot be blank."
                                                            message:@"Please provide a title for the RSS feed."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil] autorelease];
        
        [alertView show];
    }
    
    else if(!self.URL.text.length)
    {
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"URL cannot be blank."
                                                             message:@"Please provide a URL for the RSS feed."
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil] autorelease];
        
        [alertView show];
    }
    
    else
    {
        [[RSSDatabaseManager sharedDatabaseManager] createNewFeedWithDisplayName:self.RSSDisplayName.text url:self.URL.text];
    
        [self.delegate didFinishAddingNewRSS:self];
    }
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
