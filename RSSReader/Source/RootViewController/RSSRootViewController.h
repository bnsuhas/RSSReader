//
//  RSSRootViewController.h
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSAddViewController.h"

@interface RSSRootViewController : UITableViewController <RSSAddViewControllerDelegate>

- (IBAction)AddRSSFeed:(id)sender;

@end
