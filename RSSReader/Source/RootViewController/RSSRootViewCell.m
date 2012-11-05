//
//  RSSRootViewCell.m
//  RSSReader
//
//  Created by Suhas on 2/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSRootViewCell.h"

@implementation RSSRootViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_titleTextField release];
    [_subtitleTextField release];
    [_unreadCountField release];
    [_rssImageView release];
    [_UnreadCountBackgroundView release];
    [super dealloc];
}
@end
