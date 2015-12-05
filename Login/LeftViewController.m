//
//  LeftViewController.m
//  Login
//
//  Created by ParkerLovely on 15/11/8.
//  Copyright © 2015年 ParkerLovely. All rights reserved.
//

#import "LeftViewController.h"
#import "AboutViewController.h"
#import "ViewController.h"
#import "EditProfileViewController.h"
@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *array;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@"主界面", @"关于", @"退出"];
    [self loadUserDetails];
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.layer.masksToBounds = YES;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1];
    self.tableView.separatorColor = [UIColor clearColor];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.array[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        id mainVC = [delegate setupYALTabBarController];
        delegate.drawerController.centerViewController = mainVC;
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else if (indexPath.row == 1){
        id aboutVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        UINavigationController *naiv = [[UINavigationController alloc] initWithRootViewController:aboutVC];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.drawerController.centerViewController = naiv;
        [delegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }else{
        NSUserDefaults *userDefalts = [NSUserDefaults standardUserDefaults];
        [userDefalts removeObjectForKey:@"user_name"];
        [userDefalts synchronize];
        
     
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"用户正在退出";
        hud.detailsLabelText = @"请等待..";
        hud.userInteractionEnabled = NO;

        
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
            UINavigationController *naiv = [[UINavigationController alloc] initWithRootViewController:vc];
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            delegate.window.rootViewController = naiv;
            
        }];
        
        
    }
}

- (IBAction)editButtonTapped:(id)sender {
    EditProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    vc.opener = self;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (void)loadUserDetails{
    NSString *firstName = [[PFUser currentUser] objectForKey:@"first_name"];
    NSString *lastName = [[PFUser currentUser] objectForKey:@"last_name"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@", firstName, lastName];
    PFFile *file = [[PFUser currentUser] objectForKey:@"profile_picture"];
    [file getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        self.profileImageView.image = [UIImage imageWithData:data];
    }];
}

@end
