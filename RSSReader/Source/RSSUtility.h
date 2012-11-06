//
//  RSSUtility.h
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    eShareOnFaceBook = 0,
    eShareOnTwitter,
    eShareUsingMail
}ERSSShareType;

@interface RSSUtility : NSObject

+(NSManagedObjectContext *)managedObjectContext;

@end
