//
//  RSSSocialNetworkShareControllerFactory.h
//  RSSReader
//
//  Created by Suhas on 6/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface RSSSocialNetworkShareControllerFactory : NSObject

+(UIViewController *)createSocialNetworkShareControllerOfType:(ERSSShareType)inRSSShareType withText:(NSString *)inText andURL:(NSString *)inURL;

@end
