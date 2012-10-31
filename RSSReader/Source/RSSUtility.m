//
//  RSSUtility.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSUtility.h"
#import "RSSAppDelegate.h"

@implementation RSSUtility

+(NSManagedObjectContext *)managedObjectContext
{
    return [(RSSAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
