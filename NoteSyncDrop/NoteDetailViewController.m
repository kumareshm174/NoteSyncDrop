//
//  NoteDetailViewController.m
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import "NoteDetailViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "MBProgressHUD.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface NoteDetailViewController ()<DBRestClientDelegate>
@property (nonatomic, strong) DBRestClient *restClient;

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Notes Detail";

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked)];
    self.navigationItem.rightBarButtonItem = addButton;

    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;

    //Download file from dropbox and display them in detail page.
    [self updateDisplay];
    

    // Do any additional setup after loading the view.
}

-(void)updateDisplay
{
    [self.textViewNotes becomeFirstResponder];
    if (self.notes) {
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *localPath = [localDir stringByAppendingPathComponent:self.notes.Title];
        [self.restClient loadFile:self.notes.path intoPath:localPath];
        self.textFieldTitle.text = self.notes.Title;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneClicked
{
    if (![[AppDelegate appdelegate] hasConnectedToNetwork]) {
        [[AppDelegate appdelegate] showAlertFailure];
        return;
    }
    
    if (!ISSTRING(self.textFieldTitle.text)) {
        [self.textFieldTitle becomeFirstResponder];
        KAAlert(@"Alert!", @"Please add a title to your notes");
        return;
    }
    if (!ISSTRING(self.textViewNotes.text)) {
        [self.textViewNotes becomeFirstResponder];
        KAAlert(@"Alert!", @"Please add a description to your notes");
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:(self.notes)?self.notes.Title:self.textFieldTitle.text];
    [self.textViewNotes.text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // Upload file to Dropbox
    NSString *destDir = @"/Notes";
    [self.restClient uploadFile:(self.notes)?self.notes.Title:self.textFieldTitle.text toPath:destDir withParentRev:(self.notes)?self.notes.reV:nil fromPath:localPath];
}


#pragma DBRestClient Delegate

- (void)restClient:(DBRestClient *)client loadedFile:(NSString *)localPath
       contentType:(NSString *)contentType metadata:(DBMetadata *)metadata {
    NSString* description = [NSString stringWithContentsOfFile:localPath
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    self.textViewNotes.text = description;
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
    
}

- (void)restClient:(DBRestClient *)client loadFileFailedWithError:(NSError *)error {
//    NSLog(@"There was an error loading the file: %@", error);
    KAAlert(@"Sorry!",@"There was an error loading the file. Please try again later");
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
}

- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath
              from:(NSString *)srcPath metadata:(DBMetadata *)metadata {
//    NSLog(@"File uploaded successfully to path: %@", metadata.path);
    
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    [self.delegate updateFiles];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error {
//    NSLog(@"File upload failed with error: %@", error);
    KAAlert(@"Sorry!",@"File upload failed. Please try again later");
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];


}


#pragma TextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
