//
//  AppDelegate.m
//  SinaMicroBlog-iWatch
//
//  Created by XingPengfei on 1/6/16.
//  Copyright © 2016 Pengfei Xing. All rights reserved.
//

#import "AppDelegate.h"

#import "MBOAuthController.h"
#import "MBAccountTool.h"
#import "MBMainViewController.h"
#import "MBAccount.h"
#import "MBAccountTransferController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
//    NSLog(@"[MBAccountTool account] = %@",[MBAccountTool account]);
    
    if ([MBAccountTool account]) {
        MBMainViewController *mainVC = [[MBMainViewController alloc] init];
        self.window.rootViewController = mainVC;
//        MBAccountTransferController *transferVC = [[MBAccountTransferController alloc] init];
//        [transferVC transferAccount:[MBAccountTool account]];
    }else{
        MBOAuthController *oauthVC = [[MBOAuthController alloc] init];
        self.window.rootViewController = oauthVC;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
