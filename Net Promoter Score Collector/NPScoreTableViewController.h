//
//  NPScoreTableViewController.h
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPAddScoreTableViewController.h"

@interface NPScoreTableViewController : UITableViewController <NPAddScoreTableViewControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
