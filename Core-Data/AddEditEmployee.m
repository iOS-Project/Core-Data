//
//  AddEditEmployee.m
//  Core-Data
//
//  Created by Lun Sovathana on 12/10/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import "AddEditEmployee.h"
#import <CoreData/CoreData.h>

@interface AddEditEmployee ()

@end

@implementation AddEditEmployee

-(NSManagedObjectContext*)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    if (self.employee) {
        self.idTextField.text = [self.employee valueForKey:@"emp_id"];
        self.firstNameTextField.text = [self.employee valueForKey:@"first_name"];
        self.lastNameTextField.text = [self.employee valueForKey:@"last_name"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveAction:(id)sender {
    // context mean database
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // if employee data is existing just update
    if (self.employee) {
        [self.employee setValue:self.idTextField.text forKey:@"emp_id"];
        [self.employee setValue:self.firstNameTextField.text forKey:@"first_name"];
        [self.employee setValue:self.lastNameTextField.text forKey:@"last_name"];
    }else{
        // entity mean table
        NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
        
        [object setValue:self.firstNameTextField.text forKey:@"first_name"];
        [object setValue:self.lastNameTextField.text forKey:@"last_name"];
        [object setValue:self.idTextField.text.init forKey:@"emp_id"];
        
        NSError *error = nil;
        if ([context save:&error]) {
            NSLog(@"Error");
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
