//
//  RSSFeedViewController.h
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSS_Feed.h"
#import "RSS_Article.h"

@interface RSSFeedViewController : UITableViewController
{
    RSS_Feed *selectedRSSFeed_;
}

@property(nonatomic, retain) RSS_Feed *selectedRSSFeed;

@end
