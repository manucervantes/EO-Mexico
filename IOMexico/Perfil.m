//
//  Perfil.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Perfil.h"
#import <Parse/Parse.h>

@interface Perfil ()

@end

@implementation Perfil
@synthesize avatar,nombre,puesto,empresa,ciudad;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
    PFUser *user =[PFUser currentUser];
    PFQuery *query =[PFQuery queryWithClassName:@"Perfil"];
    [query whereKey:@"User" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                nombre.text = [object objectForKey:@"nombre"];
                empresa.text = [object objectForKey:@"empresa"];
                ciudad.text = [object objectForKey:@"ciudad"];
                puesto.text = [object objectForKey:@"puesto"];
                PFFile *theimage =[object objectForKey:@"foto"];
                [theimage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    NSData *imagedata = data;
                    UIImage *image = [UIImage imageWithData:imagedata];
                    avatar.image = image;
                }];
            }
        }
        else{
            NSLog(@"%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
