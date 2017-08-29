//
//  iOpticLeftMenuViewController.m
//  iOptic
//
//  Created by Satyanarayana Chebrolu on 5/24/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

#import "iOpticLeftMenuViewController.h"
#import "MenuItem.h"
#import "UIViewController+LGSideMenuController.h"
#import "AppDelegate.h"


@import Firebase;

@interface iOpticLeftMenuViewController ()
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet UILabel *displayNameLabel;
@property(nonatomic, weak) IBOutlet UILabel *emailIdLabel;

@property(nonatomic, strong) NSMutableArray<MenuItem*> *menuItemsList;
@end

@implementation iOpticLeftMenuViewController

- (void)reloadMenu
{
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user.isEmailVerified)
    {
        self.emailIdLabel.text = user.email;
        self.displayNameLabel.text = user.displayName;
    }
    else
    {
        self.emailIdLabel.text = @"";
        self.displayNameLabel.text = @"Welcome";
    }

    self.menuItemsList = [NSMutableArray new];
    MenuItem *menuItem = [MenuItem new];
    menuItem.iconName = @"home_icon";
    menuItem.title = @"home";
    menuItem.identifier = @"iOpticHomeViewController";
    [self.menuItemsList addObject:menuItem];
    
    menuItem = [MenuItem new];
    menuItem.iconName = @"about_icon";
    menuItem.title = @"about";
    menuItem.identifier = @"iOpticAboutViewController";
    [self.menuItemsList addObject:menuItem];
    
    if(user.isEmailVerified)
    {
        menuItem = [MenuItem new];
        menuItem.iconName = @"logout_icon";
        menuItem.title = @"logout";
        menuItem.identifier = @"LogoutViewController";
        [self.menuItemsList addObject:menuItem];
    }
    else
    {
        menuItem = [MenuItem new];
        menuItem.iconName = @"loginicon";
        menuItem.title = @"login";
        menuItem.identifier = @"LoginViewController";
        [self.menuItemsList addObject:menuItem];
    }
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadMenu];
    /*menuItem = [MenuItem new];
     menuItem.iconName = @"help_icon";
     menuItem.title = @"help & faq's";
     menuItem.identifier = @"iOpticHelpAndFaqsViewController";
     [self.menuItemsList addObject:menuItem];
     
     menuItem = [MenuItem new];
     menuItem.iconName = @"settings_icon";
     menuItem.title = @"settings";
     menuItem.identifier = @"iOpticSettingsViewController";
     [self.menuItemsList addObject:menuItem];*/

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuItemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"LeftMenuCell"];
    
    UILabel *label = (UILabel*)[cell viewWithTag:2];
    label.text = self.menuItemsList[indexPath.row].title;
    
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:1];
    imageView.image = [UIImage imageNamed:self.menuItemsList[indexPath.row].iconName];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGSideMenuController *sideMenuController = self.sideMenuController;
    [sideMenuController hideLeftViewAnimated];
    
    NSString *identifier = self.menuItemsList[indexPath.row].identifier;
    if([identifier isEqualToString:@"LoginViewController"])
    {
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate showLoginScreen];
    }
    else if([identifier isEqualToString:@"LogoutViewController"])
    {
        [[FIRAuth auth] signOut:nil];
        [self reloadMenu];
    }
}

@end
