//
//  ListNoteViewController.m
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import "ListNoteViewController.h"
#import "NoteDetailViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "Notes.h"
#import "MBProgressHUD.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface ListNoteViewController ()<DBRestClientDelegate,NoteDelegate>
@property (nonatomic, strong) DBRestClient *restClient;

@end

@implementation ListNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Notes List";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    if (![[AppDelegate appdelegate] hasConnectedToNetwork]) {
        [[AppDelegate appdelegate] showAlertFailure];
        return;
    }
    
    self.arrayofNotes = [NSMutableArray array];
    self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
    self.restClient.delegate = self;
    [self.restClient loadMetadata:@"/Notes"];
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

}

#pragma DBRestClient Delegate

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {

    if (metadata.isDirectory) {
        [self.arrayofNotes removeAllObjects];
        for (DBMetadata *file in metadata.contents) {
            Notes *notes = [[Notes alloc]init];;
            notes.Title  = file.filename;
            notes.path  = file.path;
            notes.reV  = file.rev;
            notes.isDirectory  = file.isDirectory;
            [self.arrayofNotes addObject:notes];
        }
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];

    }
}

- (void)restClient:(DBRestClient *)client
loadMetadataFailedWithError:(NSError *)error {
//    NSLog(@"Error loading metadata: %@", error);
    KAAlert(@"Sorry!",@"Error loading data.Please try again later");
    [MBProgressHUD hideAllHUDsForView:self.navigationController.view animated:YES];
    
}

-(void)restClient:(DBRestClient *)client deletedPath:(NSString *)path
{
    KAAlert(@"",@"File successfully deleted");
}

-(void)restClient:(DBRestClient *)client deletePathFailedWithError:(NSError *)error
{
    KAAlert(@"Sorry!",@"Error deleting file try again later");

}

//Update note files
-(void)updateFiles
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [self.restClient loadMetadata:@"/Notes"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)insertNewObject
{
    [self redirectToDetailView : nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrayofNotes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellNotes" forIndexPath:indexPath];
    // Configure the cell...
    Notes *notes = self.arrayofNotes[indexPath.row];
    cell.textLabel.text = notes.Title;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Notes *notes = self.arrayofNotes[indexPath.row];
    [self redirectToDetailView : notes];
}

-(void)redirectToDetailView :(Notes *)notes
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    NoteDetailViewController *noteView = [storyboard instantiateViewControllerWithIdentifier:@"NoteDetailView"];
    noteView.notes = notes;
    noteView.delegate = self;
    [self.navigationController pushViewController:noteView animated:YES];
   
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Notes *notes = self.arrayofNotes[indexPath.row];
        [self.arrayofNotes removeObject:notes];
        [self.restClient deletePath:notes.path];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
