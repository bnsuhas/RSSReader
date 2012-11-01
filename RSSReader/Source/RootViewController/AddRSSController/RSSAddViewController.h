//
//  RSSAddViewController.h
//  RSSReader
//
//  Created by Suhas on 31/10/12.
//  Copyright (c) 2012 Exilant Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSSAddViewController;

@protocol RSSAddViewControllerDelegate <NSObject>

-(void)didFinishAddingNewRSS:(RSSAddViewController *)inSender;

@end

@interface RSSAddViewController : UIViewController
{
    id<RSSAddViewControllerDelegate> delegate_;
}

@property (retain, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) id<RSSAddViewControllerDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITextField *RSSDisplayName;

@property (retain, nonatomic) IBOutlet UITextField *URL;

@property (retain, nonatomic) IBOutlet UISwitch *showNotifications;

- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;

@end
