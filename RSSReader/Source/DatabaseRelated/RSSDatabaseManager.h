//
//  RSSDatabaseManager.h
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSS_Article.h"

@interface RSSDatabaseManager : NSObject

+(RSSDatabaseManager *)sharedDatabaseManager;

-(RSS_Article *)createArticleWithName:(NSString *)inArticleName URL:(NSString *)inURL date:(NSDate *)inDate sourceURL:(NSURL *)inSourceURL;

-(RSS_Feed *)feedObjectForURL:(NSURL *)inURL;

@end
