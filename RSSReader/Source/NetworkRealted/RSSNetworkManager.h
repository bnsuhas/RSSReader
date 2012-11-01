//
//  RSSNetworkManager.h
//  RSSReader
//
//  Created by Suhas on 1/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSS_Article.h"
#import "RSS_Feed.h"

@interface RSSNetworkManager : NSObject
{
    NSOperationQueue *networkOperationQueue_;
}

@property(nonatomic, retain) NSOperationQueue *networkOperationQueue;

+(RSSNetworkManager *)sharedNetworkManager;

-(void)fetchAllFeedsForRSSWithURL:(NSURL *)inRSSURL;

@end
