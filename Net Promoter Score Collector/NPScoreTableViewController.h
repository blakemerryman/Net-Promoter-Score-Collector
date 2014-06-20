//
//  NPScoreTableViewController.h
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPScoreTableViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end
