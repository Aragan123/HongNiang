//
//  BGGlobalData.m
//  HongNiang
//
//  Created by JEFF ZHONG on 5/31/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import "BGGlobalData.h"

static BGGlobalData *instance = nil;

@implementation BGGlobalData

#pragma mark -
#pragma mark Data File Read & Write
- (void) loadSettingsDataFile {
	NSString *filePath = [self settingsDataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
#ifdef DEBUG
		NSLog(@"Get Settings Data File");
#endif
		//get data dictionary and set values
		NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filePath];
        //		self.pregDay = [settings objectForKey:@"DateOfPregnancy"];
        //		self.birthDay = [settings objectForKey:@"DateOfBirth"];
        //		self.cardDay = [settings objectForKey:@"DateOfCard"];
        //		self.hasPregdaySet = [[settings objectForKey:@"HasPregdaySet"] boolValue];
        //		self.hasBirthdaySet = [[settings objectForKey:@"HasBirthdaySet"] boolValue];
        //		self.hasCarddaySet = [[settings objectForKey:@"HasCarddaySet"] boolValue];
		self.topUri = [settings objectForKey:@"TopURI"];
        self.issueNumber = [settings objectForKey:@"IssueNumber"];
        self.issueFolder = [settings objectForKey:@"IssueFolder"];
        self.referrals = [settings objectForKey:@"Referrals"];
        self.adContents = [settings objectForKey:@"AdContents"];
        
	}
}

- (void) writeToSettingsDataFile {
	NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
	// set values
    //	[settings setValue:self.pregDay forKey:@"DateOfPregnancy"];
    //	[settings setValue:self.birthDay forKey:@"DateOfBirth"];
    //	[settings setValue:self.cardDay forKey:@"DateOfCard"];
    //	[settings setValue:[NSNumber numberWithBool:self.hasPregdaySet] forKey:@"HasPregdaySet"];
    //	[settings setValue:[NSNumber numberWithBool:self.hasBirthdaySet] forKey:@"HasBirthdaySet"];
    //	[settings setValue:[NSNumber numberWithBool:self.hasCarddaySet] forKey:@"HasCarddaySet"];
    
	// write to file
	[settings writeToFile:[self settingsDataFilePath] atomically:YES];
}


- (NSString *) settingsDataFilePath {
	return [[NSBundle mainBundle] pathForResource:kGlobalDataFileName ofType:@"plist"];
}

#pragma mark -
#pragma mark Utilities
- (NSArray*) arrayOfAdImages{
    if (self.adContents != nil && self.adContents.count >0) {
        int count = [self.adContents count];
        NSMutableArray *imageURIs = [[NSMutableArray alloc] initWithCapacity:count];
        
        for (int i=0; i<count; i++) {
            NSString *uri = [NSString stringWithFormat:@"%@/AdContents/%i.png", self.topUri, i];
            [imageURIs addObject:uri];
            
//            NSLog(@"add ad image URL: %@", uri);
        }
        return imageURIs;
    }else{
        return nil;
    }
}

- (NSString *) getUriStringFromString: (NSString*)str{
    if (str != nil && [str hasPrefix:@"http://"]) {
        return str;
    }
    
    // otherwise, need to construct URI string
    NSString *serverUri = kGlobalServerURI;
    if (self.topUri != nil && [self.topUri hasPrefix:@"http://"]) {
        serverUri = self.topUri;
    }
    
    return [NSString stringWithFormat:@"%@/%@", serverUri, str];
}

- (NSURL *) getNSURLFromString: (NSString*)str{
    return [NSURL URLWithString:[self getUriStringFromString:str]];
}

#pragma mark -
#pragma mark Class Definition
- (id) init {
	self = [super init];
	if (self) {
		[self loadSettingsDataFile];
	}
	return self;
}

+ (BGGlobalData *) sharedData{
    @synchronized (self) {
		if (instance == nil) {
			instance = [[BGGlobalData alloc] init];
		}
	}
	return instance;
}

+ (id)allocWithZone:(NSZone *)zone{
	@synchronized (self) {
		if (instance == nil) {
			instance = [super allocWithZone:zone];
			return instance;
		}
	}
	return nil; // on subsequent allocation attempts, return nil;
}

- (id) copyWithZone:(NSZone *)zone{
	return self;
}

@end
