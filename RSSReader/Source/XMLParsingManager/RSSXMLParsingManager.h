//
//  RSSXMLParsingManager.h
//  RSSReader
//
//  Created by Suhas on 2/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLElement+Extras.h"

@interface RSSXMLParsingManager : NSObject
{
    NSURL *sourceURL_;
    
    NSData *xmlDataToParse_;
}

@property(nonatomic, retain) NSURL *sourceURL;

@property(nonatomic, retain) NSData *xmlDataToParse;

- (id)initWithXMLData:(NSData *)inXMLData fromURL:(NSURL *)inURL;

- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries;

- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries;

- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries;

@end
