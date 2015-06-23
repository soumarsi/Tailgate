//
//  TGAppDelegate.h
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
