//
//  AddEditEmployee.h
//  Core-Data
//
//  Created by Lun Sovathana on 12/10/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEditEmployee : UIViewController

@property(strong)NSManagedObjectModel* employee;

@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
- (IBAction)saveAction:(id)sender;
@end
