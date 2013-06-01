//
//  BGGlobalData.h
//  HongNiang
//
//  Created by JEFF ZHONG on 5/31/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef kGlobalDataFileName
#define kGlobalDataFileName @"BaseData"
#define kGlobalServerURI @"http://localhost/HongNiang"
#endif

@interface BGGlobalData : NSObject{
    
}

@property (nonatomic, strong) NSString *topUri;
@property (nonatomic, strong) NSString *issueNumber;
@property (nonatomic, strong) NSString *issueFolder;
@property (nonatomic, strong) NSArray *referrals;
@property (nonatomic, strong) NSArray *adContents;

+ (BGGlobalData *) sharedData;

- (NSArray*) arrayOfAdImages;
- (NSString *) getUriStringFromString: (NSString*)str;
- (NSURL *) getNSURLFromString: (NSString*)str;

@end
