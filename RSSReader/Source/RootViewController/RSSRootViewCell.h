//
//  RSSRootViewCell.h
//  RSSReader
//
//  Created by Suhas on 2/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSRootViewCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *rssImageView;

@property (retain, nonatomic) IBOutlet UITextField *titleTextField;

@property (retain, nonatomic) IBOutlet UITextField *subtitleTextField;

@property (retain, nonatomic) IBOutlet UITextField *unreadCountField;

@property (retain, nonatomic) IBOutlet UIView *UnreadCountBackgroundView;

@end
