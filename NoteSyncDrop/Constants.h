//
//  Constants.h
//  NoteSyncDrop
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//

#define KAppKey @"71j8s3v0wb9tivk"
#define KSecretKey @"ljrd4k4obfn3w8o"


#define kFolderPath(X) [NSString stringWithFormat:@"/Notes/%@",(X)]
//Check for valid array
#define ISARRAY(X) (X && [X isKindOfClass:[NSArray class]] && [X count] > 0)

//Check for valid dictionary
#define ISDICTIONARY(X) (X && [X isKindOfClass:[NSDictionary class]] && [[X allKeys] count] > 0)

//Check for valid String
#define ISSTRING(X) (X && [X isKindOfClass:[NSString class]] && X.length > 0)

//Alert messages throughout the app
#define KAAlert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:self \
cancelButtonTitle:nil \
otherButtonTitles:@"OK",nil] show]

