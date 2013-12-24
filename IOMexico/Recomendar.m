//
//  Recomendar.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "Recomendar.h"
#import <Parse/Parse.h>

@interface Recomendar ()

@end

@implementation Recomendar
@synthesize txt_Email,txt_Empresa,txt_Nombre;

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
}
- (IBAction)regresar:(id)sender {
[self dismissViewControllerAnimated:YES  completion:nil];
}
- (IBAction)recomendar:(id)sender {
    NSString *nombre = txt_Nombre.text;
    NSString *email = txt_Email.text;
    NSString *empresa = txt_Empresa.text;
    
    if (nombre.length == 0 || email.length == 0 || empresa == 0 )
    {
        PFUser *user = [PFUser currentUser];
    }
    else{
        
        PFUser *user = [PFUser currentUser];
        NSString *Id_user = [NSString stringWithFormat:@"%@",user.objectId ];
        PFObject *recomendados = [PFObject objectWithClassName:@"Recomendados"];
        recomendados[@"Nombre"] = txt_Nombre.text;
        recomendados[@"Email"] = txt_Email.text;
        recomendados[@"Empresa"] = txt_Empresa.text;
        [recomendados setObject:user forKey:@"quien_recomienda"];
        [recomendados saveInBackground];
    }
}

- (IBAction)cerrar_teclado:(id)sender {
    [txt_Nombre resignFirstResponder];
}
- (IBAction)cerrar_tecladoEmail:(id)sender {
    [txt_Email resignFirstResponder];
}

- (IBAction)cerrar_tecladoEmpresa:(id)sender {
    [txt_Empresa resignFirstResponder];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




@end
