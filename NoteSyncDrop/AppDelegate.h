//
//  AppDelegate.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) UIAlertView *alertInternetFail;

- (int)hasConnectedToNetwork;
-(void) showAlertFailure ;
+(AppDelegate *)appdelegate;

@end

