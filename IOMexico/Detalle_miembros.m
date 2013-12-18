//
//  Detalle_miembros.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 17/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Detalle_miembros.h"
#import <Parse/Parse.h>

@interface Detalle_miembros ()

@end

@implementation Detalle_miembros
@synthesize  ides,nombre,puesto,empresa,ciudad,avatar;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regresar:(id)sender {
        [self dismissViewControllerAnimated:YES  completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    PFQuery *query =[PFQuery queryWithClassName:@"Perfil"];
    [query whereKey:@"objectId" equalTo:ides];
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
@end
