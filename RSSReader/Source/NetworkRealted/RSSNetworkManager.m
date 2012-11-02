//
//  RSSNetworkManager.m
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSNetworkManager.h"
#import "ASIHTTPRequest.h"
#import "RSSDatabaseManager.h"
#import "RSSXMLParsingManager.h"

static RSSNetworkManager *sharedNetworkManager = nil;

@implementation RSSNetworkManager

@synthesize networkOperationQueue = networkOperationQueue_;

+(RSSNetworkManager *)sharedNetworkManager
{
    @synchronized(self)
    {
        if(nil == sharedNetworkManager)
        {
            sharedNetworkManager = [[self alloc] init];
        }
    }
    
    return sharedNetworkManager;
}

#pragma mark - Singleton Related Methods

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (nil == sharedNetworkManager)
        {
            sharedNetworkManager = [super allocWithZone:zone];
            
            return sharedNetworkManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

-(id)init
{
    self = [super init];
    
    if(self)
    {
        self.networkOperationQueue = [[[NSOperationQueue alloc] init] autorelease];
    }
    
    return self;
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

-(void)fetchAllFeedsForRSSWithURL:(NSURL *)inRSSURL
{
    ASIHTTPRequest *HTTPRequest = [ASIHTTPRequest requestWithURL:inRSSURL];
    
    HTTPRequest.delegate = self;
    
    [self.networkOperationQueue addOperation:HTTPRequest];
}

#pragma mark - ASIHTTPRequest Delegate Methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
    RSSXMLParsingManager *xmlParsingMAnager = [[RSSXMLParsingManager alloc] initWithXMLData:[request responseData] fromURL:request.url];
    
    [xmlParsingMAnager performSelectorInBackground:@selector(parse) withObject:nil];
}
    

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    
    NSLog(@"Error: %@", error);
}

@end
