//
//  BGReferralDetailCell.h
//  HongNiang
//
//  Created by JEFF ZHONG on 5/31/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGReferralDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (NSString*) formatHTMLString: (NSString*) title;
@end
