//
//  NPScoreTableViewController.m
//  Net Promoter Score Collector
//
//  Created by Blake Merryman on 6/20/14.
//  Copyright (c) 2014 Blake Merryman. All rights reserved.
//

#import "NPScoreTableViewController.h"
#import "NetPromoterScore.h"

@interface NPScoreTableViewController ()

@property (nonatomic, strong) NSArray *scoreTokenImages;

@end

@implementation NPScoreTableViewController

// Manual synthesis for property; wanted to use underscore for quick access.
@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Perform fetch and check for errors...
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Error! %@",error);
        abort();
    }
    
    // Initialize array of NPS Token images
    self.scoreTokenImages = @[@"NPScoreToken-1.png", @"NPScoreToken-2.png",
                              @"NPScoreToken-3.png", @"NPScoreToken-4.png",
                              @"NPScoreToken-5.png", @"NPScoreToken-6.png",
                              @"NPScoreToken-7.png", @"NPScoreToken-8.png",
                              @"NPScoreToken-9.png", @"NPScoreToken-10.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetched Results Controller implementation

-(NSFetchedResultsController *)fetchedResultsController
{
    // If fetchedResultsController exists exists...
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    // Otherwise, we need to create one...
    // Initialize fetch request and entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"NetPromoterScore"
                                              inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];

    // Sort fetched items by value
    // TODO: by default, sort by ... ?
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"value"
                                                                   ascending:YES];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // Create new fetched results controller
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:self.managedObjectContext
                                                                      sectionNameKeyPath:nil
                                                                               cacheName:nil];

    // Return new fetched results controller
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // Fetch selected nps
    NetPromoterScore *nps = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Set the image based upon the NPScore's value
    // (Score's "value - 1" used to get token image from Zero-based array that stores them)
    cell.imageView.image = [UIImage imageNamed:[self.scoreTokenImages objectAtIndex:([[nps value]integerValue]- 1)]];
    
    // Format and set text label to date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    cell.textLabel.text = [dateFormatter stringFromDate:[nps date]];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections]objectAtIndex:section]name];
}

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

#pragma mark - NPAddScoreTableViewController Delegate Method Implementations

-(void)addScoreViewControllerDidSave
{
    // Save and check for errors
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error! %@", error);
    }
    
    // Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"NPAddScoreTableViewController dismissed successfully!");
    }];
}

-(void)addScoreViewControllerDidCancel:(NetPromoterScore *)npsToDelete
{
    // Delete passed in NPS object from context
    [self.managedObjectContext deleteObject:npsToDelete];

    // Dismiss view controller
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"NPAddScoreTableViewController dismissed successfully!");
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"AddNPS"]) {
        NPAddScoreTableViewController *astvc = (NPAddScoreTableViewController *)[segue destinationViewController];
        astvc.delegate = self;
        NetPromoterScore *newNPS = (NetPromoterScore *) [NSEntityDescription insertNewObjectForEntityForName:@"NetPromoterScore"
                                                                                      inManagedObjectContext:self.managedObjectContext];
        astvc.currentNPS = newNPS;
    }
}


@end
