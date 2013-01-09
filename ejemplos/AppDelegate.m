//
//  AppDelegate.m
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate{
    NSString *dataBaseName;
    NSString *dataBasePath;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    self.dataBasePath=[documentsDirectory stringByAppendingPathComponent:@"Agenda.sql"];
    
    [self cargaBaseDatos];
    
    return YES;
}

-(void) cargaBaseDatos{
    BOOL exito;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath= [documentsDirectory stringByAppendingPathComponent:@"Agenda.sql"];
    exito=[fileManager fileExistsAtPath:writableDBPath];
    if (exito) {
        return;
    }
    NSString *defaultDBPath= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Agenda.sql"];
    exito = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!exito) {
        NSLog(@"%@",[error localizedDescription]);
    }
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
