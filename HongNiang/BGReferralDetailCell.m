//
//  BGReferralDetailCell.m
//  HongNiang
//
//  Created by JEFF ZHONG on 5/31/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import "BGReferralDetailCell.h"

@implementation BGReferralDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString*) formatHTMLString: (NSString*) title{
    NSArray *strArray = [title componentsSeparatedByString:@";"];
    NSString *htmlString = [NSString stringWithFormat:@"<table cellpadding=\"0\" cellspacing=\"0\" width=\"280\" border=\"0\"><tr><td>年龄:%@</td><td>身高:%@</td></tr><tr><td>学历:%@</td><td>职业:%@</td></tr><tr><td colspan=\"2\">择偶标准：%@</td></tr></table>", strArray[1], strArray[2], strArray[3], strArray[4], strArray[5]];
  
//    NSString *htmlString = [NSString stringWithFormat:@"<table cellspacing=\"0\"><tr><td>%@, %@, %@, %@, %@</td></tr></table>", strArray[1], strArray[2], strArray[3], strArray[4], strArray[5]];
    return htmlString;
}

@end
