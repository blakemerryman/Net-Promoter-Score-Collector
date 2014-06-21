//
//  NPAddScoreTableViewController.m
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import "NPAddScoreTableViewController.h"

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
    
    // Format and load date...
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTextField.text = [dateFormatter stringFromDate:self.currentNPS.date];
    
    // Load comments...
    self.commentsTextView.text = self.currentNPS.comment;
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"unwindToRootViewControllerViaCancel"]) {
        
        // TODO
        // 1. Need to get managed object context
        // 2. Need to delete currentNPS from context
    
    } else if ([[segue identifier] isEqualToString:@"unwindToRootViewControllerViaSave"]) {

        // Save score text as score value
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *scoreValue = [numberFormatter numberFromString:self.scoreValueTextField.text];
        [self.currentNPS setValue:scoreValue];
        
        // Save date text as date value
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [self.currentNPS setDate:[dateFormatter dateFromString:self.dateTextField.text]];
        
        // Save comment text as comment value
        [self.currentNPS setComment:self.commentsTextView.text];
        
    }
}

@end
