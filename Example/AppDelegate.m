//
//  AppDelegate.m
//  NinaSelectionView
//
//  Created by RamWire on 16/7/20.
//  Copyright © 2016年 RamWire. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    self.window = window;
    [self.window makeKeyAndVisible];
    ViewController *viewC = [[ViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewC];
    self.window.rootViewController = navController;
    return YES;
}

@end
