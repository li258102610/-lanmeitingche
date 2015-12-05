//
//  SignUpViewController.h
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profilePhotoImageView;
@property (weak, nonatomic) IBOutlet UITextField *userEmailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordRepeatTextField;
@property (weak, nonatomic) IBOutlet UITextField *userFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userLastNameTextField;

@end
