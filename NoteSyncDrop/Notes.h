//
//  Notes.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notes : NSObject
@property(nonatomic,retain) NSString *Title;
@property(nonatomic,retain) NSString *Description;
@property(nonatomic,retain) NSString *path;
@property(nonatomic,retain) NSString *reV;

@end
