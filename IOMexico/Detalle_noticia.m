//
//  Detalle_noticia.m
//  EO Mexico City
//
//  Created by Manuel  Cervantes on 17/12/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Detalle_noticia.h"
#import <Parse/Parse.h>
@interface Detalle_noticia ()

@end

@implementation Detalle_noticia

@synthesize ides;
@synthesize imagen,titulo,mensaje;
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
    mensaje.backgroundColor =[UIColor clearColor];
    mensaje.textColor = [UIColor whiteColor];
    titulo.textColor =[UIColor whiteColor];

}

-(void) viewDidAppear:(BOOL)animated{

    PFQuery *query = [PFQuery queryWithClassName:@"Noticias"];
    [query whereKey:@"objectId" equalTo:ides];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
                titulo.text = [object objectForKey:@"Titulo"];
                mensaje.text =  [object objectForKey:@"Mensaje"];
                PFFile *theimage =[object objectForKey:@"Imagen"];
                [theimage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    NSData *imagedata = data;
                    UIImage *image = [UIImage imageWithData:imagedata];
                    imagen.image = image;
                }];
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)regresar:(id)sender {
        [self dismissViewControllerAnimated:YES  completion:nil];
}

@end
