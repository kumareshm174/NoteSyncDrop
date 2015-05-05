//
//  HomeViewController.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>

@interface HomeViewController : UIViewController<DBRestClientDelegate>
@property (nonatomic, strong) DBRestClient *restClient;

- (IBAction)linkDropBoxClicked:(id)sender;
@end
