//
//  NPAddScoreTableViewController.h
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetPromoterScore.h"

@protocol NPAddScoreTableViewControllerDelegate;

@interface NPAddScoreTableViewController : UITableViewController

// Reference to delegate
@property (nonatomic, weak) id <NPAddScoreTableViewControllerDelegate> delegate;
@property (strong, nonatomic) NetPromoterScore *currentNPS;

@end

@protocol NPAddScoreTableViewControllerDelegate
-(void)addScoreViewControllerDidCancel:(NetPromoterScore *)npsToDelete;
-(void)addScoreViewControllerDidSave;
@end