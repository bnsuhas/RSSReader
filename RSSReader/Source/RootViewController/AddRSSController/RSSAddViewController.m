//
//  RSSAddViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSAddViewController.h"

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
    [super dealloc];
}

@end
