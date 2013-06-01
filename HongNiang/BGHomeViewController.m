//
//  BGHomeViewController.m
//  HongNiang
//
//  Created by JEFF ZHONG on 5/30/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import "BGHomeViewController.h"
#import "BGGlobalData.h"
#import "BGArticleHasImageCell.h"
#import "BGArticleNoImageCell.h"
#import "BGReferralDetailCell.h"
#import "UIImageView+AFNetworking.h"

#define CARD_SEPARATOR 15.0
#define CARD_HEIGHT 115.0
#define CARD_WIDTH 306.0
#define CARD_COLOR [UIColor whiteColor]
#define CORNER_RADIUS 10.0

#define HEADER_HEIGHT 146.0
#define HEADER_COLOR [UIColor whiteColor]
#define HEADER_ON 1

NSString * const REUSE_ID_REFERRAL = @"BGReferralDetailCell";
NSString * const REUSE_ID_ARTICLENOIMAGE = @"BGArticleNoImageCell";
NSString * const REUSE_ID_ARTICLEHASIMAGE = @"BGArticleHasImageCell";

@interface BGHomeViewController ()

@end

@implementation BGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    /* customize background color/image
     */
    UIColor *backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_pattern.png"]];
    [self.view setBackgroundColor:backgroundColor];
    
    /* customize top nav bar
     */

    /* customize table view
     */
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    // add table view header - ad images
    EScrollerView *tableHeader = [[EScrollerView alloc] initWithFrameRect:CGRectMake(0.0, 0.0, self.view.frame.size.width, HEADER_HEIGHT)
                                                               ImageArray:[[BGGlobalData sharedData] arrayOfAdImages]
                                                               TitleArray:nil];
    tableHeader.delegate = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, HEADER_HEIGHT + CARD_SEPARATOR - 5.0)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    [headerView addSubview:tableHeader];
    [headerView setContentMode:UIViewContentModeCenter];
    self.tableView.tableHeaderView = headerView;
    
    /* Register Nib to TableView
     */
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        [self registerNIBs];
        nibsRegistered = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Private and Action Methods



#pragma mark -
#pragma mark EScrollerView Delegate Methods
-(void)EScrollerViewDidClicked: (NSUInteger)index{
    // when ad image is clicked
    NSLog(@"EScroller is clicked at index: %i", index);
}

#pragma mark -
#pragma mark TableView Delegate Methods & TableView related Methods
- (NSString *)reuseIdentifierForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;

    NSDictionary *referral = [[BGGlobalData sharedData].referrals objectAtIndex:rowIndex];
    NSNumber *refType = (NSNumber*)[referral objectForKey:@"Type"];

    switch ([refType intValue]) {
        case 1:
            return REUSE_ID_ARTICLENOIMAGE;
            break;
        case 2:
            return REUSE_ID_ARTICLEHASIMAGE;
            break;

        default:
            return REUSE_ID_REFERRAL;
            break;
    }
}

- (void)registerNIBs{    
    UINib *referralNib = [UINib nibWithNibName:REUSE_ID_REFERRAL bundle:[NSBundle bundleForClass:[BGReferralDetailCell class]]];         //  根据特定Bundle和Nib文件名创建UINib文件
    [[self tableView] registerNib:referralNib forCellReuseIdentifier:REUSE_ID_REFERRAL];      //  将此UINib文件注册给特定单元格
    
    UINib *articleNoImage = [UINib nibWithNibName:REUSE_ID_ARTICLENOIMAGE bundle:[NSBundle bundleForClass:[BGArticleNoImageCell class]]];
    [[self tableView] registerNib:articleNoImage forCellReuseIdentifier:REUSE_ID_ARTICLENOIMAGE];
    
    UINib *articleHasImage = [UINib nibWithNibName:REUSE_ID_ARTICLEHASIMAGE bundle:[NSBundle bundleForClass:[BGArticleHasImageCell class]]];
    [[self tableView] registerNib:articleHasImage forCellReuseIdentifier:REUSE_ID_ARTICLEHASIMAGE];
    
}


/****************************************************************************************************************
 Returns the number of cards 
 ****************************************************************************************************************/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[BGGlobalData sharedData].referrals count]; // number of cell items
}

/****************************************************************************************************************
 Returns the the height of the card and proper spacing between them.
 ****************************************************************************************************************/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // different cell type has different cell row height
    /* Basically, there are three types:
     * 0. Referrals from parent
     * 1. News withOut Image
     * 2. News has image
     */
    UITableViewCell *cell = [self tableView:[self tableView] cellForRowAtIndexPath:indexPath];
    NSLog(@"cell height=%f", cell.frame.size.height);
    return (cell.frame.size.height + CARD_SEPARATOR);
}

/****************************************************************************************************************
 This method allocates the UITableView cell (the card), initializes it with the card attributes, and populates the
 content inside the cell. If the cell object has already been allocated, reuse in the view.
 ****************************************************************************************************************/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath];      // get resue ID
    NSDictionary *referral = [[BGGlobalData sharedData].referrals objectAtIndex:indexPath.row];
    
    
    if ([REUSE_ID_ARTICLENOIMAGE isEqualToString:reuseID] == YES) {
        BGArticleNoImageCell *cell = (BGArticleNoImageCell*)[[self tableView] dequeueReusableCellWithIdentifier:reuseID];
        [cell.title setText:[referral objectForKey:@"Title"]];
        [cell.subtitle setText:[referral objectForKey:@"SubTitle"]];
        [cell.reporter setText:[referral objectForKey:@"Reporter"]];

        return cell;
        
    }
    else if ([REUSE_ID_ARTICLEHASIMAGE isEqualToString:reuseID] == YES) {
        BGArticleHasImageCell *cell = (BGArticleHasImageCell*)[[self tableView] dequeueReusableCellWithIdentifier:reuseID];
        [cell.title setText:[referral objectForKey:@"Title"]];
        [cell.reporter setText:[referral objectForKey:@"Reporter"]];
        
        NSString *imageString = [referral objectForKey:@"Image"];
        NSURL *imageUrl = [[BGGlobalData sharedData] getNSURLFromString:imageString];
        
        [cell.photo setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@""]];
        
        return cell;
        
    }else{
        BGReferralDetailCell *cell = (BGReferralDetailCell*)[[self tableView] dequeueReusableCellWithIdentifier:reuseID];
        [cell.webView loadHTMLString:[cell formatHTMLString:[referral objectForKey:@"Title"]] baseURL:nil];
        return cell;
    }

//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

/****************************************************************************************************************
 When cell is selected
 ****************************************************************************************************************/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseID = [self reuseIdentifierForRowAtIndexPath:indexPath];      // get resue ID

    NSLog(@"Index %i selected, Type is %@", indexPath.row, reuseID);
}
@end
