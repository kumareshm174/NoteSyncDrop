//
//  NoteDetailViewController.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Notes.h"

@protocol NoteDelegate <NSObject>

@required
-(void)updateFiles;

@end

@interface NoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewNotes;
@property (nonatomic,retain) Notes *notes;
@property(unsafe_unretained)id<NoteDelegate> delegate;

@end
