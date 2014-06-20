//
//  NPAddScoreTableViewController.h
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetPromoterScore.h"

@interface NPAddScoreTableViewController : UITableViewController

@property (strong, nonatomic) NetPromoterScore *currentNPS;

@end