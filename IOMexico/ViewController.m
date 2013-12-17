//
//  ViewController.m
//  IOMexico
//
//  Created by Manuel  Cervantes on 26/11/13.
//  Copyright (c) 2013 Manuel  Cervantes. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "Principal.h"

@interface ViewController ()
@end


@implementation ViewController
@synthesize txt_Contra,txt_Usuario;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self placeholder];
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    if(user != nil){
        [self cambiarPantalla];
    }
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {

    NSString *user_name = txt_Usuario.text;
    NSString *pass = txt_Contra.text;
    [PFUser logInWithUsernameInBackground:user_name password:pass
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            
                                            [self cambiarPantalla];
                                            // Do stuff after successful login.
                                        } else {
                                            
                                            UIAlertView *alert_error  = [[UIAlertView alloc ] initWithTitle:@"Error" message:@"Nombre de usuario o contraseña invalidos" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                                            [alert_error show];
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    
    

}

- (IBAction)cerrarTeclado:(id)sender {
    [txt_Contra resignFirstResponder];
    
}

- (IBAction)cerrarTeclado1:(id)sender {
    [txt_Usuario resignFirstResponder];
}

- (void) cambiarPantalla{
    
    Principal *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"principal"];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void) placeholder{
    // @"#fff1dc"
    UIColor *color = [UIColor colorWithRed:1 green:0.945 blue:0.863 alpha:1];
    txt_Contra.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contraseña" attributes:@{NSForegroundColorAttributeName: color}];
    txt_Usuario.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Nombre de Usuario" attributes:@{NSForegroundColorAttributeName: color}];
}

@end
