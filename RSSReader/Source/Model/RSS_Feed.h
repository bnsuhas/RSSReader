//
//  RSS_Feed.h
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSS_Article;

@interface RSS_Feed : NSManagedObject

@property (nonatomic, retain) NSNumber * displayNotifications;
@property (nonatomic, retain) NSString * feed_url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *articles;
@end

@interface RSS_Feed (CoreDataGeneratedAccessors)

- (void)addArticlesObject:(RSS_Article *)value;
- (void)removeArticlesObject:(RSS_Article *)value;
- (void)addArticles:(NSSet *)values;
- (void)removeArticles:(NSSet *)values;

@end
