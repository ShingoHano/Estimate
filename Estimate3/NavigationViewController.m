//
//  NavigationViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//
//  Sample icons from http://icons8.com/download-free-icons-for-ios-tab-bar
//

#import "NavigationViewController.h"
#import "SettingViewController.h"
#import "ResultViewController.h"
#import "ProspectViewController.h"
#import "EstimateViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationBar.tintColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
    self.navigationBar.tintColor=[UIColor blackColor];
    
    // Blocks maintain strong references to any captured objects, including self,
    // which means that it’s easy to end up with a strong reference cycle if, for example,
    // an object maintains a copy property for a block that captures self
    // (which is the case for REMenu action blocks).
    //
    // To avoid this problem, it’s best practice to capture a weak reference to self:
    //
    __typeof (&*self) __weak weakSelf = self;
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Estimate"
                                                    subtitle:NSLocalizedString(@"家計の予算編成",nil)
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
//                                                          NSLog(@"Item: %@", item);
                                                          EstimateViewController *controller = [[EstimateViewController alloc] init];
                                                          [weakSelf setViewControllers:@[controller] animated:NO];
                                                      }];
    
    REMenuItem *resultItem = [[REMenuItem alloc] initWithTitle:@"Result"
                                                       subtitle:NSLocalizedString(@"過去3ヶ月の記録",nil)
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             //                                                             NSLog(@"Item: %@", item);
                                                             ResultViewController *controller = [[ResultViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    REMenuItem *prospectItem = [[REMenuItem alloc] initWithTitle:@"Prospect"
                                                      subtitle:NSLocalizedString(@"将来1年の資産推移",nil)
                                                         image:nil
                                              highlightedImage:nil
                                                        action:^(REMenuItem *item) {
                                                            //                                                             NSLog(@"Item: %@", item);
                                                            ProspectViewController *controller = [[ProspectViewController alloc] init];
                                                            [weakSelf setViewControllers:@[controller] animated:NO];
                                                        }];
    
    REMenuItem *settingItem = [[REMenuItem alloc] initWithTitle:@"Setting"
                                                       subtitle:NSLocalizedString(@"セルのカスタマイズ",nil)
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
                                                             SettingViewController *controller = [[SettingViewController alloc] init];
                                                             [weakSelf setViewControllers:@[controller] animated:NO];
                                                         }];
    
    // You can also assign custom view for items
    // Uncomment the code below and add customViewItem to `initWithItems` array, e.g.
    // [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]]
    //
    /*
     UIView *customView = [[UIView alloc] init];
     customView.backgroundColor = [UIColor blueColor];
     customView.alpha = 0.4;
     REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
     NSLog(@"Tap on customView");
     }];
     */
    
    /*
    homeItem.tag = 0;
    resultItem.tag=1;
    prospectItem.tag=2;
    settingItem.tag=3;*/
    
    /*
    exploreItem.tag = 1;
    activityItem.tag = 2;
    profileItem.tag = 3;*/
    
    _menu = [[REMenu alloc] initWithItems:@[homeItem,resultItem,prospectItem,settingItem]];
    _menu.cornerRadius = 4;
    _menu.shadowRadius = 4;
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 1);
    _menu.shadowOpacity = 1;
    _menu.imageOffset = CGSizeMake(5, -1);
    _menu.waitUntilAnimationIsComplete = NO;
}

- (void)toggleMenu
{
    if (_menu.isOpen)
        return [_menu close];
    
    [_menu showFromNavigationController:self];
}

@end
