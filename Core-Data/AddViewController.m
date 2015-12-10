//
//  AddViewController.m
//  Core-Data
//
//  Created by Lun Sovathana on 12/9/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import "AddViewController.h"
#import <CoreData/CoreData.h>

@interface AddViewController ()

@end

@implementation AddViewController

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if update data
    if (self.phone) {
        self.phoneName.text = [self.phone valueForKey:@"brand"];
        self.phoneModel.text = [self.phone valueForKey:@"model"];
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

- (IBAction)addAction:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    if (self.phone) {
        // update the existing field
        [self.phone setValue:self.phoneName.text forKey:@"brand"];
        [self.phone setValue:self.phoneModel.text forKey:@"model"];
    }else{
        // add new row
        // NSManagedObject is a table
        NSManagedObject *newPhone = [NSEntityDescription insertNewObjectForEntityForName:@"Phone" inManagedObjectContext:context];
        [newPhone setValue:self.phoneName.text forKey:@"brand"];
        [newPhone setValue:self.phoneModel.text forKey:@"model"];
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Error : %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
