//
//  RSSXMLParsingManager.m
//  RSSReader
//
//  Created by Suhas on 2/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSXMLParsingManager.h"
#import "RSS_Article.h"
#import "RSSDatabaseManager.h"

@implementation RSSXMLParsingManager

@synthesize sourceURL = sourceURL_;
@synthesize xmlDataToParse = xmlDataToParse_;

-(id)initWithXMLData:(NSData *)inXMLData fromURL:(NSURL *)inURL
{
    self = [super init];
    
    if(nil != self)
    {
        self.sourceURL = inURL;
        
        self.xmlDataToParse = inXMLData;
    }
    
    return self;
}

-(void)dealloc
{
    self.sourceURL = nil;
    
    self.xmlDataToParse = nil;
    
    [super dealloc];
}

-(void)parse
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:self.xmlDataToParse
                                                           options:0 error:&error];
    if (doc == nil)
    {
        NSLog(@"Failed to parse %@", self.sourceURL.absoluteString);
    }
    
    else
    {
        NSMutableArray *entries = [NSMutableArray array];
        [self parseFeed:doc.rootElement entries:entries];
    }
    
    [pool release];
}

- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries
{
    if ([rootElement.name compare:@"rss"] == NSOrderedSame)
    {
        [self parseRss:rootElement entries:entries];
    }
    
    else if ([rootElement.name compare:@"feed"] == NSOrderedSame)
    {
        [self parseAtom:rootElement entries:entries];
    }
    
    else
    {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }
}

- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries
{
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels)
    {
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items)
        {
            NSString *articleTitle = [item valueForChild:@"title"];
            NSString *articleUrl = [item valueForChild:@"link"];
            //NSString *articleDateString = [item valueForChild:@"pubDate"];
            NSDate *articleDate = nil;
            
            [[RSSDatabaseManager sharedDatabaseManager] createArticleWithName:articleTitle
                                                                          URL:articleUrl
                                                                         date:articleDate
                                                                    sourceURL:self.sourceURL];
        }
    }
    
}

- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries
{
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items)
    {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];
        for(GDataXMLElement *link in links)
        {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue];
            if ([rel compare:@"alternate"] == NSOrderedSame &&
                [type compare:@"text/html"] == NSOrderedSame)
            {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        //NSString *articleDateString = [item valueForChild:@"updated"];
        NSDate *articleDate = nil;
        
        [[RSSDatabaseManager sharedDatabaseManager] createArticleWithName:articleTitle
                                                                      URL:articleUrl
                                                                     date:articleDate
                                                                sourceURL:self.sourceURL];
        
    }
    
}

@end
