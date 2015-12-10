//
//  AddViewController.h
//  Core-Data
//
//  Created by Lun Sovathana on 12/9/15.
//  Copyright © 2015 Lun Sovathana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phoneName;
@property (weak, nonatomic) IBOutlet UITextField *phoneModel;
@property (weak, nonatomic) IBOutlet UIButton *addPhone;
@property(strong)NSManagedObjectModel *phone;

- (IBAction)addAction:(id)sender;

@end
