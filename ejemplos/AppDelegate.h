//
//  AppDelegate.h
//  ejemplos
//
//  Created by Xavi on 21/12/12.
//  Copyright (c) 2012 Xavi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) NSString *dataBaseName;
@property (nonatomic,retain) NSString *dataBasePath;

@end
