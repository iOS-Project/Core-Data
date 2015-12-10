//
//  EmployeeTable.m
//  Core-Data
//
//  Created by Lun Sovathana on 12/9/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import "EmployeeTable.h"
#import <CoreData/CoreData.h>
#import "AddEditEmployee.h"

@interface EmployeeTable ()
@property(strong)NSMutableArray *data;
@end

@implementation EmployeeTable

-(NSManagedObjectContext*)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

-(void)viewDidAppear:(BOOL)animated{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // fetch data from database
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    // add data fetched to collection
    self.data = [[context executeFetchRequest:request error:nil] mutableCopy];
    // reload table
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
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"empCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Full Name: %@ %@", [[self.data objectAtIndex:indexPath.row] valueForKey:@"first_name"], [[self.data objectAtIndex:indexPath.row] valueForKey:@"last_name"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"ID: %@", [[self.data objectAtIndex:indexPath.row] valueForKey:@"emp_id"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"editEmpSegue" sender:[self.data objectAtIndex:indexPath.row]];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
    
    if ([segue.identifier isEqualToString:@"editEmpSegue"]) {
        AddEditEmployee *emp = segue.destinationViewController;
        emp.employee = sender;
    }
    
}


@end
