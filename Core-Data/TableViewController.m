//
//  TableViewController.m
//  Core-Data
//
//  Created by Lun Sovathana on 12/9/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import "TableViewController.h"
#import "AddViewController.h"
#import <CoreData/CoreData.h>

@interface TableViewController ()

@property(strong)NSMutableArray *phone;

@end

@implementation TableViewController

// setup method to manage object
-(NSManagedObjectContext *)managedObjectContext{
    // create ManagedObjectContext object
    NSManagedObjectContext *context;
    // declate delegate to get the whole application delegate
    id delegate = [[UIApplication sharedApplication] delegate];
    // if delegate perform this method then set managedObjectContext to the above (context) object
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

-(void)viewDidAppear:(BOOL)animated{
    // invoke the managedObjectContext to get instance from UIApplication
    NSManagedObjectContext *context = [self managedObjectContext];
    // link request with Entity
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Phone"];
    // set data that was fetched to Arrray
    self.phone = [[context executeFetchRequest:request error:nil] mutableCopy];
    
    // reload tableview
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.phone.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phoneCell" forIndexPath:indexPath];
    // get object for each row
    NSManagedObjectModel *phone = [self.phone objectAtIndex:indexPath.row];
    cell.textLabel.text = [phone valueForKey:@"brand"];
    cell.detailTextLabel.text = [phone valueForKey:@"model"];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self managedObjectContext];
    // if the editing style is delete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete row from database
        [context deleteObject:[self.phone objectAtIndex:indexPath.row]];
        
        // commit transaction
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"Error: %@ %@", error, [error localizedDescription]);
        }
        
        // remove object from array
        [self.phone removeObjectAtIndex:indexPath.row];
        
        // delete row from table
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"updatePhoneCell"]) {
        NSManagedObjectModel *selectedPhone = [self.phone objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        AddViewController *addView = segue.destinationViewController;
        addView.phone = selectedPhone;
    }
}


@end
