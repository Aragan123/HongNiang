//
//  BGHomeViewController.h
//  HongNiang
//
//  Created by JEFF ZHONG on 5/30/13.
//  Copyright (c) 2013 Brute Game Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"

@interface BGHomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EScrollerViewDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
