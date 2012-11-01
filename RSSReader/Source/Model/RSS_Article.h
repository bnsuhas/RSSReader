//
//  RSS_Article.h
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSS_Feed;

@interface RSS_Article : NSManagedObject

@property (nonatomic, retain) NSString * article_url;
@property (nonatomic, retain) NSNumber * isRead;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) RSS_Feed *feed;

@end
