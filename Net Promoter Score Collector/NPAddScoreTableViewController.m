//
//  NPAddScoreTableViewController.m
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import "NPAddScoreTableViewController.h"
#import "NPAppDelegate.h"

@interface NPAddScoreTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *scoreValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@end

@implementation NPAddScoreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Format and load score value...
    self.scoreValueTextField.text = [NSString stringWithFormat:@"%d", self.currentNPS.value.intValue];
    
    // Format & load today's date...
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTextField.text = [dateFormatter stringFromDate:[NSDate date]];
    
    // Load comments, if any...
    if (self.currentNPS.comment != nil) {
        self.commentsTextView.text = self.currentNPS.comment;
    }
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToRootViewControllerViaCancel"]) {
        
        // TODO: 1. Get managed object context
        NPAppDelegate *myApp = (NPAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        // TODO: 2. Delete currentNPS from context
        [myApp.managedObjectContext deleteObject:self.currentNPS];
    
    } else if ([[segue identifier] isEqualToString:@"unwindToRootViewControllerViaSave"]) {

        // Format & Save score string as score value
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *scoreValue = [numberFormatter numberFromString:self.scoreValueTextField.text];
        [self.currentNPS setValue:scoreValue];
        
        // Format & Save date string as date value
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [self.currentNPS setDate:[dateFormatter dateFromString:self.dateTextField.text]];
        
        // If any, Save comment string as comment value
        if (self.commentsTextView.text != nil) {
            [self.currentNPS setComment:self.commentsTextView.text];
        }
        
    }
    
}

@end
