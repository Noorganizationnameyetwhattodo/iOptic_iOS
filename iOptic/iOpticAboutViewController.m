//
//  iOpticAboutViewController.m
//  iOptic
//
//  Created by Satyanarayana Chebrolu on 9/9/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

#import "iOpticAboutViewController.h"
#import "AppDelegate.h"

@interface iOpticAboutViewController ()
@property(nonatomic, weak) IBOutlet UILabel *versionNumberLabel;
@end

@implementation iOpticAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *versionNo = [[NSBundle mainBundle] infoDictionary] [@"CFBundleShortVersionString"];
    self.versionNumberLabel.text = [NSString stringWithFormat:@"iOptic %@",versionNo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) closeTapped:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [appDelegate goToMainViewController];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
