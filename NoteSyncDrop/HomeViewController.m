//
//  HomeViewController.m
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import "HomeViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "ListNoteViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Note_Sync";
    
    if ([[DBSession sharedSession] isLinked]) {
        NSLog(@"App linked successfully!");

        // At this point you can start making API calls

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        ListNoteViewController *nc = [storyboard instantiateViewControllerWithIdentifier:@"ListNoteView"];
        [self.navigationController pushViewController:nc animated:NO];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)linkDropBoxClicked:(id)sender
{
    if (![[DBSession sharedSession] isLinked]) {
        [[DBSession sharedSession] linkFromController:self];
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        ListNoteViewController *nc = [storyboard instantiateViewControllerWithIdentifier:@"ListNoteView"];
        [self.navigationController pushViewController:nc animated:YES];
    }

}
@end
