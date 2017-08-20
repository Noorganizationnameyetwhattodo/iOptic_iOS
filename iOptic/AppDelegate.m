//
//  AppDelegate.m
//  iOptic
//
//  Created by Satyanarayana Chebrolu on 5/23/17.
//  Copyright © 2017 mycompany. All rights reserved.
//

#import "AppDelegate.h"
#import "LGSideMenuController.h"
#import "iOptic-Swift.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@import Firebase;
@import GoogleSignIn;

#define GOOGLE_ID @"com.googleusercontent.apps.132862184286-arlft1df9f5sqld5jrdoote1m6ce1pld"
#define FB_ID com.googleusercontent.apps.132862184286-arlft1df9f5sqld5jrdoote1m6ce1pld


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"bundleId:%@",[[NSBundle mainBundle] bundleIdentifier]);
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isTutorialShown"] boolValue]){
        [self performSelectorInBackground:@selector(formGIFsInBackground) withObject:nil];
    }
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    
    [FIRApp configure];
    
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    [GIDSignIn sharedInstance].delegate = self;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
//    GIDSignIn.sharedInstance.clientID = FIRApp.op
//    
//    
//    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//    GIDSignIn.sharedInstance().delegate = self
//    
//    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

    
    _walkthough = [[SwiftyOnboardVC alloc] init];
    _walkthough.hideStatusBar = YES;
    _walkthough.showPageControl = YES;

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *moviePath = [bundle pathForResource:@"splash" ofType:@"mp4"];
    if (moviePath)
    {
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        controller.showsPlaybackControls = NO;
        self.window.rootViewController = controller;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSURL* movieURL = [NSURL fileURLWithPath:moviePath];
            AVPlayer *player = [AVPlayer playerWithURL:movieURL];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(continueWithLaunch) name: AVPlayerItemDidPlayToEndTimeNotification object:player.currentItem];
            controller.player = player;
            [player play];
        });
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
        
        [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"ViewController"]]];
        
        LGSideMenuController *sideMenuController = [LGSideMenuController new];
        sideMenuController.rootViewController = navigationController;
        sideMenuController.leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"iOpticLeftMenuViewController"];
        
        sideMenuController.leftViewWidth = 300;
        UIWindow *window = UIApplication.sharedApplication.delegate.window;
        window.rootViewController = sideMenuController;
        
        
        [UIView transitionWithView:window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




//- (BOOL)application:(UIApplication *)app
//            openURL:(NSURL *)url
//            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
//{
//    
//    if ([url.scheme isEqualToString:GOOGLE_ID]){
//        BOOL handled = [[GIDSignIn sharedInstance] handleURL:url sourceApplication:options[UIApplicationLaunchOptionsSourceApplicationKey]
//                                                  annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
//        
//       return handled ;//
//    }else{
//       return [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationLaunchOptionsSourceApplicationKey]
//                                                    annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
//    }
//    
//    
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme isEqualToString:GOOGLE_ID]){
        BOOL handled = [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication
                                                  annotation:annotation];
        
        return handled ;//
    }else{
        return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication                                                           annotation:annotation];
    }
    
}

- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    if (error != nil){
        NSLog(@"error occured:%@",error);
    }
    
    if (user.authentication == nil){
        return;
    }
    
    GIDAuthentication *authentication = user.authentication;
    FIRAuthCredential *credential =
    [FIRGoogleAuthProvider credentialWithIDToken:authentication.idToken
                                     accessToken:authentication.accessToken];
    
    
    [[FIRAuth auth] signInWithCredential:credential
                              completion:^(FIRUser *user, NSError *error) {
                                  if (error) {
                                      // ...
                                      NSLog(@"error occured during google login:%@",error.localizedDescription);
                                      return;
                                  }
                                  // User successfully signed in. Get user data from the FIRUser object
                                  // ...
                              }];
    
}



-(void)formGIFsInBackground
{
    self.firstGIF = [[NSMutableArray alloc] init];

    for (int i=1; i <= 45; i++) {
        @autoreleasepool {
            NSString *imgName = [NSString stringWithFormat:@"1_%d", i];
            UIImage *image = [UIImage imageNamed:imgName];
            [self.firstGIF addObject:image];
        }
    }
    
    self.secondGIF = [[NSMutableArray alloc] init];
    
    for (int i=1; i <= 120; i++) {
        @autoreleasepool {
            NSString *imgName = [NSString stringWithFormat:@"2_%d", i];
            UIImage *image = [UIImage imageNamed:imgName];
            [self.secondGIF addObject:image];
        }
    }
    
    self.thirdGIF = [[NSMutableArray alloc] init];
    
    for (int i=1; i <= 150; i++) {
        @autoreleasepool {
            NSString *imgName = [NSString stringWithFormat:@"3_%d", i];
            UIImage *image = [UIImage imageNamed:imgName];
            [self.thirdGIF addObject:image];
        }
    }
    
   
}

-(void)continueWithLaunch
{
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isTutorialShown"] boolValue]){
        [self showLoginScreen];
    }else{
        [self showTutorial];
    }
    
    
}

-(void)showTutorial
{
    UIStoryboard *onBoardStoryBoard = [UIStoryboard storyboardWithName:@"OnBoard" bundle:nil];
    FirstOnBoardViewController *firstViewController = [onBoardStoryBoard instantiateViewControllerWithIdentifier:@"FirstOnBoardScene"];
    
    SecondOnBoardViewController *secondViewController = [onBoardStoryBoard instantiateViewControllerWithIdentifier:@"SeondOnBoardScene"];
    
    ThirdOnBoardViewController *thirdViewController = [onBoardStoryBoard instantiateViewControllerWithIdentifier:@"ThirdOnBoardScene"];
    
    _walkthough.viewControllers = @[firstViewController,secondViewController,thirdViewController];
    self.window.backgroundColor = [UIColor greenColor];
    
    _walkthough.bounces = NO;
    _walkthough.showLeftButton = NO;
    _walkthough.showRightButton = NO;
    _walkthough.showHorizontalScrollIndicator = YES;
    self.window.rootViewController = _walkthough;
}


-(void)showLoginScreen
{
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *loginViewController = [loginStoryboard instantiateInitialViewController];
    self.window.rootViewController = loginViewController;

}


-(void)goToMainViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    
    [navigationController setViewControllers:@[[storyboard instantiateViewControllerWithIdentifier:@"ViewController"]]];
    
    LGSideMenuController *sideMenuController = [LGSideMenuController new];
    sideMenuController.rootViewController = navigationController;
    sideMenuController.leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"iOpticLeftMenuViewController"];
    
    sideMenuController.leftViewWidth = 300;
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    window.rootViewController = sideMenuController;
    
    
    [UIView transitionWithView:window
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:nil
                    completion:nil];
}


@end
