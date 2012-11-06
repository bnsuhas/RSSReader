//
//  RSSViewController.m
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import "RSSWebViewController.h"
#import "RSSSocialNetworkShareControllerFactory.h"

@interface RSSWebViewController ()

@end

@implementation RSSWebViewController

@synthesize articleToDisplay = articleToDisplay_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.articleToDisplay.article_url]]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}

- (IBAction)shareArticle:(id)sender
{
    UIActionSheet *shareActionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Article"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"Facebook",@"Twitter",@"Mail", nil];
    
    [shareActionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIViewController *shareViewController = [RSSSocialNetworkShareControllerFactory createSocialNetworkShareControllerOfType:buttonIndex
                                                                            withText:self.articleToDisplay.name
                                                                              andURL:self.articleToDisplay.article_url];
    
    if([shareViewController isKindOfClass:[MFMailComposeViewController class]])
    {
        [(MFMailComposeViewController *)shareViewController setMailComposeDelegate:self];
    }
    
    [self presentViewController:shareViewController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
