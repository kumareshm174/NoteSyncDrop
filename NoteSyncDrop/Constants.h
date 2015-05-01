//
//  Constants.h
//  Tenmiles
//
//  Created by Kumaresh Mutharasan on 30/04/15.
//  Copyright (c) 2015 Kumaresh Mutharasan. All rights reserved.
//


//Check for valid array
#define ISARRAY(X) (X && [X isKindOfClass:[NSArray class]] && [X count] > 0)

//Check for valid dictionary
#define ISDICTIONARY(X) (X && [X isKindOfClass:[NSDictionary class]] && [[X allKeys] count] > 0)

//Check for valid String
#define ISSTRING(X) (X && [X isKindOfClass:[NSString class]] && X.length > 0)



