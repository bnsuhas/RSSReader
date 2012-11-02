//
//  RSSViewController.h
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSS_Article.h"

@interface RSSWebViewController : UIViewController
{
    RSS_Article *articleToDisplay_;
}

@property (retain, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic, retain) RSS_Article *articleToDisplay;

@end
