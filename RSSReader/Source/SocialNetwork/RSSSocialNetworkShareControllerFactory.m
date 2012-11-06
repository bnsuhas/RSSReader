//
//  RSSSocialNetworkShareControllerFactory.m
//  RSSReader
//
//  Created by Suhas on 6/11/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSSocialNetworkShareControllerFactory.h"

@implementation RSSSocialNetworkShareControllerFactory

+(UIViewController *)createSocialNetworkShareControllerOfType:(ERSSShareType)inRSSShareType withText:(NSString *)inText andURL:(NSString *)inURL
{
    UIViewController *socialNetworkShareController;
    
    switch (inRSSShareType)
    {
        case eShareOnFaceBook:
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
                {
                    
                    if (result == SLComposeViewControllerResultCancelled)
                    {
                        
                        NSLog(@"Cancelled");
                        
                    }
                    
                    else
                    {
                        NSLog(@"Done");
                    }
                    
                    [controller dismissViewControllerAnimated:YES completion:Nil];
                };
                
                controller.completionHandler =myBlock;
                
                [controller setInitialText:inText];
                [controller addURL:[NSURL URLWithString:inURL]];
                
                socialNetworkShareController = controller;
                
            }
            
            else
            {
                NSLog(@"UnAvailable");
            }
            
            break;
            
        case eShareOnTwitter:
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                
                SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result)
                {
                    if (result == SLComposeViewControllerResultCancelled)
                    {
                        
                        NSLog(@"Cancelled");
                        
                    }
                    
                    else
                    {
                        NSLog(@"Done");
                    }
                    
                    [controller dismissViewControllerAnimated:YES completion:Nil];
                };
                
                controller.completionHandler =myBlock;
                
                [controller setInitialText:inText];
                [controller addURL:[NSURL URLWithString:inURL]];
                
                socialNetworkShareController = controller;
                
            }
            
            else
            {
                NSLog(@"UnAvailable");
            }
            
            break;
            
        case eShareUsingMail:
            
            break;
            
        default:
            break;
    }
    
    return socialNetworkShareController;
}

@end
