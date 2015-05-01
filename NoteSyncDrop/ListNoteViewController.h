//
//  ListNoteViewController.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListNoteViewController : UITableViewController
@property(nonatomic,retain)NSMutableArray *arrayofNotes;
@property(unsafe_unretained)id delegate;
@end
