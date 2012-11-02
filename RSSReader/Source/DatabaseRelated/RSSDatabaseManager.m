//
//  RSSDatabaseManager.m
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSDatabaseManager.h"



static RSSDatabaseManager *sharedDatabaseManager = nil;

@implementation RSSDatabaseManager

+(RSSDatabaseManager *)sharedDatabaseManager
{
    @synchronized(self)
    {
        if(nil == sharedDatabaseManager)
        {
            sharedDatabaseManager = [[self alloc] init];
        }
    }
    
    return sharedDatabaseManager;
}

#pragma mark - Singleton Related Methods

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (nil == sharedDatabaseManager)
        {
            sharedDatabaseManager = [super allocWithZone:zone];
            
            return sharedDatabaseManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

-(oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

#pragma mark - Instance Methods

-(RSS_Article *)createArticleWithName:(NSString *)inArticleName URL:(NSString *)inURL date:(NSDate *)inDate sourceURL:(NSURL *)inSourceURL;
{
    NSManagedObjectContext *context = [RSSUtility managedObjectContext];
    
    RSS_Article *article = [NSEntityDescription insertNewObjectForEntityForName:@"RSS_Article" inManagedObjectContext:context];
    
    article.name = inArticleName;
    
    article.article_url = inURL;
    
    article.date = inDate;
    
    article.isRead = [NSNumber numberWithBool:NO];
    
    article.feed = [self feedObjectForURL:inSourceURL];
    
    [context save:nil];
    
    return article;
}

-(RSS_Feed *)feedObjectForURL:(NSURL *)inURL
{
    NSManagedObjectContext *context = [RSSUtility managedObjectContext];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"RSS_Feed"];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"feed_url like %@",inURL.absoluteString]];
    
    NSArray *feedsArray = [context executeFetchRequest:fetchRequest error:nil];
    
    return [feedsArray lastObject];
}

@end
