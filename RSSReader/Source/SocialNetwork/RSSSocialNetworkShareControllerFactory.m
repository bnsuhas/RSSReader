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
    UIViewController *socialNetworkShareController = nil;
    
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
            
            break;
            
        case eShareUsingMail:
            
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailer = [[[MFMailComposeViewController alloc] init] autorelease];
                
                [mailer setSubject:inText];
                
                [mailer setMessageBody:inURL isHTML:NO];
                
                socialNetworkShareController = mailer;
            }
            
            break;
            
        default:
            break;
    }
    
    if(nil == socialNetworkShareController)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    return socialNetworkShareController;
}

@end
