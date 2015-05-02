//
//  AppDelegate.m
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import "AppDelegate.h"
#import <DropboxSDK/DropboxSDK.h>
#import "HomeViewController.h"
#import "ListNoteViewController.h"
#import "Constants.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *root = kDBRootDropbox;
    
    NSString* errorMsg = nil;
    if ([KAppKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
        errorMsg = @"Make sure you set the app key correctly";
    } else if ([KSecretKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
        errorMsg = @"Make sure you set the app secret correctly";
    } else if ([root length] == 0) {
        errorMsg = @"Set your root to use either App Folder or full Dropbox";
    }
    
    DBSession *dbSession = [[DBSession alloc]
                            initWithAppKey:KAppKey
                            appSecret:KSecretKey
                            root:root]; // either kDBRootAppFolder or kDBRootDropbox
    [DBSession setSharedSession:dbSession];

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation {
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            UINavigationController *navController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            ListNoteViewController *nc = [storyboard instantiateViewControllerWithIdentifier:@"ListNoteView"];
            [navController pushViewController:nc animated:NO];
//            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}

+(AppDelegate *)appdelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (int)hasConnectedToNetwork
{
    return [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
}

-(void) showAlertFailure {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (!self.alertInternetFail) {
        self.alertInternetFail = [[UIAlertView alloc]
                                  initWithTitle:@"Internet not available"
                                  message:@"NoteSyncDrop needs an active internet connection in order to proceed!"
                                  delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"Ok", nil];
    }
    
    if (!self.alertInternetFail.visible) {
        [self.alertInternetFail show];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
