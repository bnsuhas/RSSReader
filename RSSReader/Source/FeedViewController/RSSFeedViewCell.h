//
//  RSSFeedViewCell.h
//  RSSReader
//
//  Created by Suhas on 2/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSFeedViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *unreadImageView;

@property (retain, nonatomic) IBOutlet UITextField *titleTextField;

@property (retain, nonatomic) IBOutlet UITextField *subtitleTextField;

@end
